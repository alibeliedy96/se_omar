// File: booking_calendar_controller.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_omar/utils/uti.dart';


import '../../../unit_details/domain/models/unit_details_response.dart';
import '../../domain/models/bulk_pricing_response.dart';
import '../../domain/request/bulk_pricing_request.dart';
import '../../logic/choose_days_and_book_cubit/choose_days_and_book_cubit.dart';
// --- نهاية الافتراضات ---

// Enum for the state of each day in the calendar
enum DayState { available, reserved, selected, inRange, invalid }

// Data model for each day in the calendar
class CalendarDay {
  final DateTime date;
  DayState state;
  CalendarDay({required this.date, this.state = DayState.available});
}

class BookingCalendarController extends ChangeNotifier {
  final ChooseDaysAndBookCubit _cubit = ChooseDaysAndBookCubit.get();
  final UnitDetailsData unit;

  // --- State Variables ---
  bool isLoading = true;
  int get currentPageIndex => _currentPageIndex;
  Map<String, List<CalendarDay>> months = {};
  List<String> monthKeys = [];
  Set<DateTime> _reservedDays = {};

  // Selection State
  DateTime? _selectionStart;
  DateTime? _selectionEnd;

  // Checkout State
  BulkPricingResponse? bulkPricingSummary;
  bool isCheckingPrice = false;

  // UI State
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  String get currentMonthLabel => monthKeys.isNotEmpty ? monthKeys[_currentPageIndex] : '';

  BookingCalendarController({required this.unit}) {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    _generateLocalCalendar();
    await _fetchReservedDays();
    _mergeApiDataWithCalendar();

    isLoading = false;
    notifyListeners();
  }

  // في ملف booking_calendar_controller.dart

  void _generateLocalCalendar() {
    months.clear();
    monthKeys.clear();
    // استخدم DateUtils.dateOnly لضمان أننا نقارن التاريخ فقط بدون وقت
    final now = DateUtils.dateOnly(DateTime.now());

    for (int i = 0; i < 3; i++) {
      final monthDate = DateTime(now.year, now.month + i, 1);
      final key = DateFormat('MMMM yyyy', 'ar').format(monthDate);
      monthKeys.add(key);

      final daysInMonth = DateUtils.getDaysInMonth(monthDate.year, monthDate.month);
      final List<CalendarDay> days = [];

      // --- بداية التعديل ---

      // 1. حساب الأيام الفارغة في بداية الشهر لمحاذاة الشبكة
      // (يوم الاثنين = 1، الأحد = 7). في مصر، الأسبوع يبدأ السبت.
      // سنفترض أن `weekday` يرجع 6 للسبت و 7 للأحد.
      int firstDayWeekday = monthDate.weekday;
      // إذا كان الأسبوع يبدأ السبت (6)، فإننا لا نحتاج لأيام فارغة
      // إذا كان الأحد (7)، نحتاج ليوم فارغ واحد، وهكذا.
      // يمكنك تعديل هذا السطر ليتناسب مع بداية الأسبوع عندك
      int placeholders = (firstDayWeekday == 7) ? 0 : firstDayWeekday;

      // 2. لا تقم بإضافة أيام فارغة للشهر الحالي (أغسطس)
      // هذا سيجعل التقويم يبدأ من اليوم الحالي مباشرة
      if (i == 0) {
        // لا تفعل شيئًا، لن نضيف أيام فارغة
      } else {
        for (int j = 0; j < placeholders; j++) {
          days.add(CalendarDay(date: DateTime(0), state: DayState.invalid));
        }
      }

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(monthDate.year, monthDate.month, day);

        // 3. تعديل الشرط ليكون صريحًا: أي يوم قبل "اليوم" يعتبر غير صالح
        if (date.isBefore(now)) {
          // لا تقم بإضافة الأيام السابقة للشهر الحالي
          if (i == 0) continue;

          // في الشهور المستقبلية، يمكن إضافتها كأيام غير صالحة (إذا أردت ذلك)
          days.add(CalendarDay(date: date, state: DayState.invalid));
        } else {
          days.add(CalendarDay(date: date));
        }
      }
      // --- نهاية التعديل ---

      months[key] = days;
    }
  }

  Future<void> _fetchReservedDays() async {
    final now = DateTime.now();
    final startDate = DateFormat('yyyy-MM-dd').format(now);
    final endDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 3, 0));

     await _cubit.reservedDays(unitId: unit.id.toString(),
        startDate: startDate, endDate: endDate,
    onSuccess: (response) {
      if (response.data != null) {
        _reservedDays = response.data!.map((dateStr) => DateUtils.dateOnly(DateTime.parse(dateStr))).toSet();
      }
    },);

  }

  void _mergeApiDataWithCalendar() {
    months.forEach((month, days) {
      for (var day in days) {
        if (_reservedDays.contains(day.date)) {
          day.state = DayState.reserved;
        }
      }
    });
  }

  void onDaySelected(CalendarDay day) {
    if (day.state != DayState.available && day.state != DayState.selected) return;

    if (_selectionStart != null && _selectionEnd != null) {
      // Start a new selection
      _selectionStart = day.date;
      _selectionEnd = null;
    } else if (_selectionStart == null) {
      // This is the first tap
      _selectionStart = day.date;
    } else {
      // This is the second tap
      if (day.date.isBefore(_selectionStart!)) {
        _selectionStart = day.date;
      } else {
        _selectionEnd = day.date;
      }
    }
    _updateDayStates();

  }

  void _updateDayStates() {
    months.forEach((month, days) {
      for (var day in days) {
        if (day.state == DayState.invalid || day.state == DayState.reserved) continue;

        day.state = DayState.available; // Reset first

        if (_selectionStart != null && _selectionEnd != null) {
          if (day.date.isAtSameMomentAs(_selectionStart!) || day.date.isAtSameMomentAs(_selectionEnd!)) {
            day.state = DayState.selected;
          } else if (day.date.isAfter(_selectionStart!) && day.date.isBefore(_selectionEnd!)) {
            day.state = DayState.inRange;
          }
        } else if (_selectionStart != null && day.date.isAtSameMomentAs(_selectionStart!)) {
          day.state = DayState.selected;
        }
      }
    });
    notifyListeners();
  }



  Future<void> fetchBulkPricing(BuildContext context) async {
    if (_selectionStart == null || _selectionEnd == null) {
      bulkPricingSummary = null;
      notifyListeners();
      return;
    }

    int nights = _selectionEnd!.difference(_selectionStart!).inDays;
     print("nights");
     print(nights);
    if (nights < 2) {
      bulkPricingSummary = null;
      notifyListeners();
      UTI.showSnackBar(context, "يجب أن يكون الحجز على الأقل 3 ليالي", "error");


      return;
    }

    // Check for reserved days in range
    for (DateTime date = _selectionStart!;
    date.isBefore(_selectionEnd!);
    date = date.add(const Duration(days: 1))) {
      if (_reservedDays.contains(date)) {
        bulkPricingSummary = null;
        notifyListeners();
        return; // Found a reserved day in the selection
      }
    }

    isCheckingPrice = true;
    notifyListeners();

    final request = BulkPricingRequest(
      unitId: int.parse(unit.id.toString()),
      dateRanges: [
        DateRange(
          checkInDate: DateFormat('yyyy-MM-dd').format(_selectionStart!),
          checkOutDate: DateFormat('yyyy-MM-dd').format(_selectionEnd!),
        )
      ],
    );

    await _cubit.bulkPricing(
      bulkPricingRequest: request,
      onSuccess: (response) {
        bulkPricingSummary = response;
      },
    );

    isCheckingPrice = false;
    notifyListeners();
  }


  void onMonthChanged(int page) {
    _currentPageIndex = page;
    notifyListeners();
  }

  void nextMonth() {
    if (_currentPageIndex < monthKeys.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void previousMonth() {
    if (_currentPageIndex > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
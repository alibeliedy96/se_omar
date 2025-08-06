import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../main.dart';
import '../../domain/models/check_coupon_response.dart';
import '../../domain/models/show_advisor_appointments_response.dart';


class ChooseTimeController extends ChangeNotifier {
  List<ShowAdvisorAppointmentsData> appointmentDays = [];
  int selectedDayIndex = 0;
  int? selectedAppointmentId;
  CheckCouponData? checkCouponData;
  final formKey = GlobalKey<FormState>();
  final checkCouponController = TextEditingController();
  String? _couponCode;

  ShowAdvisorAppointmentsData? get currentDayData =>
      appointmentDays.isNotEmpty ? appointmentDays[selectedDayIndex] : null;

  ShowAdvisorAppointments? get selectedAppointment {
    try {
      return currentDayData?.appointments?.firstWhere((e) => e.id == selectedAppointmentId);
    } catch (_) {
      return null;
    }
  }

  void selectDay(int index) {
    if (selectedDayIndex != index) {
      selectedDayIndex = index;
      selectedAppointmentId = null;
      notifyListeners();
    }
  }

  void selectTime(ShowAdvisorAppointments appointment) {
    if (appointment.status == 'AVAILABLE') {
      selectedAppointmentId = appointment.id;
      notifyListeners();
    }
  }

  void showAppointmentBookingDialog(BuildContext context) {
    if (selectedAppointmentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يجب اختيار موعد أولاً")),
      );
      return;
    }

    // showBookAppointmentDialog(
    //   appointmentId: selectedAppointmentId!,
    //   sessionPrice: selectedAppointment?.price,
    //   isFree: selectedAppointment?.isFree,
    //   finalPrice: checkCouponData?.finalPrice,
    //   couponCode: _couponCode,
    // );
  }

  static List<ShowAdvisorAppointmentsData> generateFakeAdvisorAppointments() {
    final Random random = Random();
    final AdviserInfo fakeAdviser = AdviserInfo(id: 1, fullName: "علي بليدي", fullNameAr: "علي بليدي");

    return List.generate(70, (dayIndex) {
      final DateTime currentDate = DateTime.now().add(Duration(days: dayIndex));
      final String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

      final appointmentsList = List.generate(random.nextInt(6) + 3, (i) {
        final hour = 8 + i * 2;
        final localTime = DateTime(currentDate.year, currentDate.month, currentDate.day, hour);

        final statuses = ['AVAILABLE', 'BOOKED', 'COMPLETED', 'CANCELLED'];
        final status = statuses[random.nextInt(statuses.length)];
        final isFree = random.nextBool();

        return ShowAdvisorAppointments(
          id: (dayIndex * 100) + i,
          startTimeLocal: DateFormat('yyyy-MM-dd HH:mm').format(localTime),
          durationMinutes: 45,
          price: isFree ? null : (random.nextDouble() * 100).toStringAsFixed(2),
          status: status,
          isFree: isFree,
          adviser: fakeAdviser,
        );
      });

      appointmentsList.sort((a, b) => a.startTimeLocal!.compareTo(b.startTimeLocal!));

      return ShowAdvisorAppointmentsData(
        date: formattedDate,
        appointments: appointmentsList,
        totalAppointments: appointmentsList.length,
      );
    });
  }
}

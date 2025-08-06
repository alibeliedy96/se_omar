import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:mr_omar/main.dart';

import '../../../../language/app_localizations.dart';
import '../../domain/models/show_advisor_appointments_response.dart';
import '../view/choose_available_days_controller.dart';

class ChooseDayWidget extends StatefulWidget {
  final ChooseTimeController controller;
  const ChooseDayWidget({super.key, required this.controller});

  @override
  State<ChooseDayWidget> createState() => _ChooseDayWidgetState();
}

class _ChooseDayWidgetState extends State<ChooseDayWidget> {
  late final PageController _pageController;
  late final Map<String, List<ShowAdvisorAppointmentsData>> _monthsMap;
  late final List<String> _monthKeys;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();


    _monthsMap = {};
    for (var appointment in widget.controller.appointmentDays) {
      final date = DateTime.parse(appointment.date!);
      final key = DateFormat('MMMM yyyy', langCode).format(date);
      _monthsMap.putIfAbsent(key, () => []).add(appointment);
    }
    _monthKeys = _monthsMap.keys.toList();
  }

  void _goToPage(int page) {
    if (page >= 0 && page < _monthKeys.length) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
               Loc.alized.discount_code,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const Icon(Icons.style),
            const Spacer(),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller.checkCouponController,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return  Loc.alized.please_enter_the_discount_code;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: Loc.alized.enter_the_discount_code,
            hintStyle: const TextStyle(
              color:  Colors.black
                 ,
            ),
            filled: true,
            fillColor: const Color(0xFFF3F3F3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: InkWell(
              onTap: () {
                if (widget.controller.formKey.currentState!.validate()) {

                }
              },
              child: Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                ),
              ),
            ),
          ),

        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => _goToPage(_currentPage - 1),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _monthKeys[_currentPage],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => _goToPage(_currentPage + 1),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),


        SizedBox(
          height: 410,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _monthKeys.length,
            itemBuilder: (context, pageIndex) {
              final days = _monthsMap[_monthKeys[pageIndex]]!;
              return AlignedGridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 5,
                padding: const EdgeInsets.all(5),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount:days.length,
                itemBuilder: (context, index) {
                  final dayData = days[index];
                  final date = DateTime.parse(dayData.date!);
                  final isSelected = widget.controller.selectedDayIndex == index &&
                      widget.controller.appointmentDays[index].date == dayData.date;

                  return _daysWidget(index, isSelected, context, date);
                },
              );


            },
          ),
        )
      ],
    );
  }

  Widget _daysWidget(int index, bool isSelected, BuildContext context, DateTime date) {
    return InkWell(
      onTap: () => widget.controller.selectDay(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEEE', 'ar').format(date),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat.Md(langCode).format(date),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

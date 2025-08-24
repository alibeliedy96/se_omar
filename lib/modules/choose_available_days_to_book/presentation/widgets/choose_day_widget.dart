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
        /// --- Monthly Pricing Design ---
        if (widget.controller.monthlyPricing != null &&
            widget.controller.monthlyPricing!.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.controller.monthlyPricing!.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final pricing = widget.controller.monthlyPricing![index];
                final isActive = pricing.isActive ?? false;

                return Container(
                  width: 160,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pricing.formattedMonth ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${pricing.dailyPrice} ${pricing.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isActive ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            isActive
                                ? Icons.check_circle
                                : Icons.remove_circle_outline,
                            color: isActive ? Colors.white : Colors.black45,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isActive ? "Active" : "Inactive",
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? Colors.white : Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 20),

        /// --- Months Navigation (next/prev arrows) ---
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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

        /// --- Days Grid ---
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
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final dayData = days[index];
                  final date = DateTime.parse(dayData.date!);
                  final isSelected =
                      widget.controller.selectedDayIndex == index &&
                          widget.controller.appointmentDays[index].date ==
                              dayData.date;

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

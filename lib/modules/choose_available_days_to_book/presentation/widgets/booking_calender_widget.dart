import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:mr_omar/main.dart';

import '../../../../language/app_localizations.dart';
import '../view/choose_available_days_controller.dart';


class BookingCalendarWidget extends StatelessWidget {
  final BookingCalendarController controller;
  const BookingCalendarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        if (controller.unit.monthlyPricing != null &&
            controller.unit.monthlyPricing!.isNotEmpty)
          _buildMonthlyPricing(context),

        const SizedBox(height: 10),

        _buildMonthNavigator(context),

        Expanded(child: _buildCalendarPages(context)),
      ],
    );
  }


  Widget _buildMonthlyPricing(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: controller.unit.monthlyPricing!.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final pricing = controller.unit.monthlyPricing![index];
          final isActive = pricing.isActive ?? false;

          return Container(
            width: 160,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade200,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "${pricing.dailyPrice} ${pricing.currency}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive ? Colors.white70 : Colors.black54),
                ),
                // const SizedBox(height: 6),
                // Row(
                //   children: [
                //     Icon(isActive ? Icons.check_circle : Icons.remove_circle_outline, color: isActive ? Colors.white : Colors.black45, size: 18),
                //     const SizedBox(width: 6),
                //     Text(isActive ? "Active" : "Inactive", style: TextStyle(fontSize: 12, color: isActive ? Colors.white : Colors.black54)),
                //   ],
                // )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthNavigator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: controller.currentPageIndex > 0 ? controller.previousMonth : null,
          ),
          Text(
            controller.currentMonthLabel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: controller.currentPageIndex < controller.monthKeys.length - 1 ? controller.nextMonth : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarPages(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: controller.onMonthChanged,
      itemCount: controller.monthKeys.length,
      itemBuilder: (context, pageIndex) {
        final monthKey = controller.monthKeys[pageIndex];
        final days = controller.months[monthKey]!;

        return AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 5,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 10,
          itemCount: days.length,
          itemBuilder: (context, dayIndex) {
            final day = days[dayIndex];

            return _buildDayItem(context, day);
          },
        );
      },
    );
  }

  Widget _buildDayItem(BuildContext context, CalendarDay day) {
    Color backgroundColor = Colors.grey.shade200;
    Color textColor = Colors.black87;
    bool isTappable = false;

    switch (day.state) {
      case DayState.available:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.black87;
        isTappable = true;
        break;
      case DayState.reserved:
        backgroundColor = Colors.grey.shade400;
        textColor = Colors.white;
        isTappable = false;
        break;
      case DayState.selected:
        backgroundColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
        isTappable = true;
        break;
      case DayState.inRange:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.2);
        textColor = Theme.of(context).primaryColor;
        isTappable = true;
        break;
      case DayState.invalid:
        return const SizedBox.shrink();
    }

    if (day.date.isBefore(DateUtils.dateOnly(DateTime.now()))) {
      isTappable = false;
      backgroundColor = Colors.grey.shade100;
      textColor = Colors.grey.shade400;
    }

    return InkWell(
      onTap: isTappable ? () => controller.onDaySelected(day) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEEE', "ar").format(day.date),
                style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat.Md(langCode).format(day.date),
                style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              if (day.state == DayState.reserved)
                Text(
                  Loc.alized.egp,
                  style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 10),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
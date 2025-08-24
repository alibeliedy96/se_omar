import 'package:flutter/material.dart';

import '../../../../language/app_localizations.dart';
import '../view/choose_available_days_controller.dart';
import 'book_button.dart';
import 'choose_day_widget.dart';

class AppointmentsView extends StatelessWidget {
  final ChooseTimeController controller;
  const AppointmentsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Text( Loc.alized.choose_from_the_available_days, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, )),
              const SizedBox(height: 10),
              ChooseDayWidget(controller: controller),
              const SizedBox(height: 20),
            ],
          ),
        ),
        BookButtonWidget(controller: controller),
      ],
    );
  }
}

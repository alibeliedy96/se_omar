import 'package:flutter/material.dart';

import '../../../../language/app_localizations.dart';
import '../view/choose_available_days_controller.dart';


class BookButtonWidget extends StatelessWidget {
  final ChooseTimeController controller;
  const BookButtonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 10, offset: Offset(0, -2))],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => controller.showAppointmentBookingDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child:   Text( Loc.alized.book_now, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
              color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

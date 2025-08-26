// File: book_button_widget.dart

import 'package:flutter/material.dart';
import '../../../../language/app_localizations.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/choose_days_and_book_cubit/choose_days_and_book_cubit.dart';
import '../view/choose_available_days_controller.dart';

class BookButtonWidget extends StatelessWidget {
  final BookingCalendarController controller;
  const BookButtonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    final bool isRangeSelected = controller.bulkPricingSummary != null;

    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 10, offset: Offset(0, -2))],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        children: [

          BlockBuilderWidget<ChooseDaysAndBookCubit, ChooseDaysAndBookApiTypes>(

            types: const [ChooseDaysAndBookApiTypes.bulkPricing],
            loading: (_) => Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),
            body: (_) =>  _continueToPayBtn(context),
            error: (_) => _continueToPayBtn(context),
          )

        ],
      ),
    );
  }

  SizedBox _continueToPayBtn(BuildContext context) {
    return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(

            onPressed: () => controller.fetchBulkPricing(context),

            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
             Loc.alized.continue_to_pay,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
  }
}
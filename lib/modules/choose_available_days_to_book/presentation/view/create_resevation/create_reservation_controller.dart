// File: create_reservation_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mr_omar/utils/uti.dart';


import '../../../../../core/cache/cache_helper.dart';
import '../../../../../language/app_localizations.dart';
import '../../../../../routes/route_names.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../bottom_tab/bottom_tab_screen.dart';
import '../../../domain/models/bulk_pricing_response.dart';
import '../../../domain/request/create_reservation_request.dart';
import '../../../logic/choose_days_and_book_cubit/choose_days_and_book_cubit.dart';


class CreateReservationController extends ChangeNotifier {
  final ChooseDaysAndBookCubit _cubit = ChooseDaysAndBookCubit.get();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final guestNameController = TextEditingController();
  final guestPhoneController = TextEditingController();
  final guestEmailController = TextEditingController();
  final specialRequestsController = TextEditingController();
  final transferAmountController = TextEditingController();
  final transferDateController = TextEditingController();
  File? transferImage;
  bool isSaving = false;

  /// Picks an image from the gallery for the bank transfer.
  Future<void> pickTransferImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      transferImage = File(pickedFile.path);
      notifyListeners();
    }
  }
  CreateReservationController() {
    fillData();

  }
  fillData()async{
    transferDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    guestNameController.text=await CacheHelper.getData(key: AppConstants.userName,)??"";
    guestEmailController.text=await CacheHelper.getData(key: AppConstants.userEmail,)??"";
    guestPhoneController.text=await CacheHelper.getData(key: AppConstants.phoneNumber,)??"";
  }
  /// Clears the picked transfer image.
  void clearTransferImage() {
    transferImage = null;
    notifyListeners();
  }

  /// Shows a date picker for the transfer date.
  Future<void> pickTransferDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );


    if (pickedDate != null) {
      transferDateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    } else {

      transferDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  /// Validates the form and calls the cubit to create the reservation.
  Future<void> submitReservation(
      BuildContext context, {
        required BulkPricingResponse pricingSummary,
      }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }


    if (transferImage == null) {
      UTI.showSnackBar(context, "${Loc.alized.transfer_receipt_image} ${Loc.alized.required_field}", "error");
      return;
    }

    isSaving = true;
    notifyListeners();

    final dateRange = pricingSummary.data!.dateRanges!.first;

    final request = CreateReservationRequest(
      unitId: pricingSummary.data!.summary!.unitId!,
      checkInDate: dateRange.checkInDate!,
      checkOutDate: dateRange.checkOutDate!,
      guestName: guestNameController.text.trim(),
      guestPhone: guestPhoneController.text.trim(),
      guestEmail: guestEmailController.text.trim(),
      specialRequests: specialRequestsController.text.trim(),
      transferImage: transferImage,
      transferAmount: double.tryParse(transferAmountController.text.trim()),
      transferDate: transferDateController.text.trim(),
    );

    await _cubit.createReservation(
      createReservationRequest: request,
      onSuccess: (response) {
        UTI.showSnackBar(context, response.message, "success");
        NavigationServices(context).navigateAndFinish(context, const BottomTabScreen(initialTab: BottomBarType.trips));
      },
    );

    isSaving = false;
    notifyListeners();
  }


  @override
  void dispose() {
    guestNameController.dispose();
    guestPhoneController.dispose();
    guestEmailController.dispose();
    specialRequestsController.dispose();
    transferAmountController.dispose();
    transferDateController.dispose();
    super.dispose();
  }
}
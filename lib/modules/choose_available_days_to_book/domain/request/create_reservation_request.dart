import 'dart:io';
import 'package:dio/dio.dart';

class CreateReservationRequest {
  final int unitId;
  final String checkInDate; // format: yyyy-MM-dd
  final String checkOutDate; // format: yyyy-MM-dd
  final String guestName;
  final String guestPhone;
  final String guestEmail;
  final String? specialRequests;
  final File? transferImage;
  final double? transferAmount;
  final String? transferDate; // format: yyyy-MM-dd

  CreateReservationRequest({
    required this.unitId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestName,
    required this.guestPhone,
    required this.guestEmail,
    this.specialRequests,
    this.transferImage,
    this.transferAmount,
    this.transferDate,
  });


  Map<String, dynamic> toJson() {
    return {
      "unit_id": unitId,
      "check_in_date": checkInDate,
      "check_out_date": checkOutDate,
      "guest_name": guestName,
      "guest_phone": guestPhone,
      "guest_email": guestEmail,
      "special_requests": specialRequests,
      "transfer_amount": transferAmount,
      "transfer_date": transferDate,
    };
  }


  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "unit_id": unitId.toString(),
      "check_in_date": checkInDate,
      "check_out_date": checkOutDate,
      "guest_name": guestName,
      "guest_phone": guestPhone,
      "guest_email": guestEmail,
      if (specialRequests != null) "special_requests": specialRequests!,
      if (transferAmount != null) "transfer_amount": transferAmount.toString(),
      if (transferDate != null) "transfer_date": transferDate!,
      if (transferImage != null)
        "transfer_image": await MultipartFile.fromFile(
          transferImage!.path,
          filename: transferImage!.path.split('/').last,
        ),
    });
  }
}

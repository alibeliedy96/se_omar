// File: create_reservation_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mr_omar/utils/color_resources.dart';
import '../../../../../language/app_localizations.dart';
import '../../../domain/models/bulk_pricing_response.dart';
import 'create_reservation_controller.dart';

class CreateReservationBottomSheet extends StatefulWidget {
  final BulkPricingResponse pricingSummary;
  const CreateReservationBottomSheet({super.key, required this.pricingSummary});

  @override
  State<CreateReservationBottomSheet> createState() => _CreateReservationBottomSheetState();
}

class _CreateReservationBottomSheetState extends State<CreateReservationBottomSheet> {
  late final CreateReservationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateReservationController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _controller.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(

                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                    Text(Loc.alized.transfer_data, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  _buildTextField(controller: _controller.transferAmountController, label: Loc.alized.transferred_amount, keyboardType: TextInputType.number),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _controller.transferDateController,
                    label: Loc.alized.transfer_date,
                    readOnly: true,
                    onTap: () => _controller.pickTransferDate(context),
                    suffixIcon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 12),

                  _buildTextField(controller: _controller.specialRequestsController, label: Loc.alized.additional_data, isRequired: false, maxLines: 3),
                  const SizedBox(height: 12),
                  _buildImagePicker(),
                  const Divider(height: 30),
                  Text( Loc.alized.enter_contact_information, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  _buildTextField(controller: _controller.guestNameController, label: Loc.alized.fullName),
                  const SizedBox(height: 12),
                  _buildTextField(controller: _controller.guestPhoneController, label: Loc.alized.enter_your_phone, keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  _buildTextField(controller: _controller.guestEmailController, label: Loc.alized.your_mail, keyboardType: TextInputType.emailAddress),


                  const SizedBox(height: 32),


                ],
              ),
            ),
            _controller.isSaving
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _controller.submitReservation(context, pricingSummary: widget.pricingSummary),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child:   Text(Loc.alized.confirm_your_reservation, style: const TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    bool isRequired = true,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onTap,
    IconData? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return Loc.alized.required_field;
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text( Loc.alized.transfer_receipt_image, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _controller.pickTransferImage(),
          borderRadius: BorderRadius.circular(12),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 6],
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _controller.transferImage == null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey.shade600),
                    const SizedBox(height: 8),
                      Text( Loc.alized.attach_the_transfer_image),
                  ],
                ),
              )
                  : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_controller.transferImage!, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, color: Colors.white, size: 18),
                        onPressed: () => _controller.clearTransferImage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
          Text(Loc.alized.please_attach_a_clear_photo_of_the_transfer, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

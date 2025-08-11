
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_omar/utils/uti.dart';

import '../../domain/models/profile_response.dart';
import '../../domain/request/edit_profile_request.dart';
import '../../logic/profile_cubit/profile_cubit.dart';


class EditProfileController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ProfileCubit _cubit = ProfileCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  GetProfileData? _profileData;
  bool _isLoading = true;
  File? _pickedImageFile;

  // -- Text Editing Controllers --
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // ==========================
  //      Public Getters
  // ==========================
  GetProfileData? get profileData => _profileData;
  bool get isLoading => _isLoading;
  File? get pickedImageFile => _pickedImageFile;

  // ==========================
  //      Initialization
  // ==========================
  void init(BuildContext context) {
    fetchProfile(context);
  }

  /// Fetches the user profile and populates the text fields.
  Future<void> fetchProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await _cubit.getProfile(
      context: context,
      onSuccess: (response) {
        _profileData = response.data;
        if (_profileData != null) {
          // Populate controllers with fetched data
          nameController.text = _profileData!.name ?? '';
          emailController.text = _profileData!.email ?? '';
          phoneController.text = _profileData!.phoneNumber ?? '';
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  // ==========================
  //      Public Methods (UI Actions)
  // ==========================

  /// Picks an image from the gallery.
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedFile != null) {
      _pickedImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// Validates the form and calls the cubit to update the profile.
  Future<void> updateProfile(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    // Basic Validation
    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      UTI.showSnackBar(context, "الرجاء ملء جميع الحقول", "error");
      return;
    }

    final request = EditProfileRequest(
      name: name,
      email: email,
      phoneNumber: phone,
      // You can add the image file to the request if your API supports it
      // profileImage: _pickedImageFile,
    );

    // Call the cubit to perform the update
    await _cubit.editProfile(context: context, editProfile: request);
  }

  // ==========================
  //      Lifecycle
  // ==========================
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/common_text_field_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../constants/themes.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../logic/profile_cubit/profile_cubit.dart';
import 'edit_profile_controller.dart'; // Import the new controller
import 'package:cached_network_image/cached_network_image.dart'; // To display network image


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final EditProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditProfileController();
    _controller.addListener(_refresh);
    _controller.init(context);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RemoveFocuse(
        onClick: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: Loc.alized.edit_profile,
              onBackClick: () => Navigator.pop(context),
            ),
            Expanded(
              // The main body is now a SingleChildScrollView to prevent keyboard overflow
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Skeletonizer(
                  enabled: _controller.isLoading,
                  child: Column(
                    children: [
                      // 1. Display data and allow editing
                      _buildProfileImage(),
                      const SizedBox(height: 32),

                      // 2. Replace Text with TextFields
                      CommonTextFieldView(
                        titleText: Loc.alized.fullName,
                        controller: _controller.nameController,
                        hintText: Loc.alized.fullName,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFieldView(
                        titleText: Loc.alized.your_mail,
                        controller: _controller.emailController,
                        hintText: Loc.alized.enter_your_email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      CommonTextFieldView(
                        titleText: Loc.alized.your_phone,
                        controller: _controller.phoneController,
                        hintText: Loc.alized.enter_your_phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 40),

                      // 4. Activate the edit button
                      BlockBuilderWidget<ProfileCubit, ProfileApiTypes>(
                        types: const [ProfileApiTypes.editProfile],
                        loading: (_) => Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,),),
                        body: (_) => _editProfile(context),
                        error: (_) => _editProfile(context),
                      )
                      ,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CommonButton _editProfile(BuildContext context) {
    return CommonButton(
                      buttonText: Loc.alized.save,
                      onTap: () => _controller.updateProfile(context),
                    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Theme.of(context).dividerColor, blurRadius: 8, offset: const Offset(4, 4))],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60.0)),
              // Display picked file if it exists, otherwise display network image
              child: _controller.pickedImageFile != null
                  ? Image.file(_controller.pickedImageFile!, fit: BoxFit.cover)
                  : CachedNetworkImage(
                // imageUrl: _controller.profileData?.avatar ?? '',
                imageUrl:  '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(Localfiles.appIcon),
                errorWidget: (context, url, error) => Image.asset(Localfiles.appIcon),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: CommonCard(
              color: Theme.of(context).primaryColor,
              radius: 36,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: _controller.pickImage,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.surface, size: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
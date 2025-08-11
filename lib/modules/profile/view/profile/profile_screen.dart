// File: profile_screen.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/profile/view/profile/profile_controller.dart';
import 'package:mr_omar/widgets/bottom_top_move_animation_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../models/setting_list_data.dart';
import '../../../../widgets/base_cached_image_widget.dart';



class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;
  const ProfileScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. Create an instance of the controller.
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    widget.animationController.forward();
    _controller = ProfileController();
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
    List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Skeletonizer(
        enabled: _controller.isLoading,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: _buildAppBar(),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: userSettingsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    // 2. Navigation logic is now in the controller
                    onTap: () => _controller.onSettingsItemTapped(context, index),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    userSettingsList[index].titleTxt,
                                    style: TextStyles(context).regular().copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(userSettingsList[index].iconData, color: AppTheme.secondaryTextColor.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Divider(height: 1),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 3. The AppBar now gets its data from the controller.
  Widget _buildAppBar() {
    final profileData = _controller.profileData;

    return InkWell(
      onTap: () => _controller.goToEditProfile(context),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileData?.name ?? Loc.alized.amanda_text, // Dynamic name
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    Loc.alized.view_edit,
                    style: TextStyle(fontSize: 18, color: Theme.of(context).disabledColor),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                // Dynamic image with a placeholder
                child:
                // profileData?.avatar != null
                //     ? CachedImageWidget(
                //   imageUrl: profileData?.avatar??"",
                //   fit: BoxFit.cover,
                //
                //
                // )
                //     :
                Image.asset(Localfiles.appIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}
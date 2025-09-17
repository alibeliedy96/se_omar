// File: settings_screen.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';

import '../../../../constants/themes.dart';
import '../../../../models/setting_list_data.dart';
import 'settings_controller.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 1. Create an instance of the controller.
  late final SettingsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SettingsController();
    // A listener is needed to update the theme icon when it changes.
    _controller.addListener(_refresh);
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
      body: RemoveFocuse(
        onClick: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.pop(context),
              titleText: Loc.alized.setting_text,
            ),
            Expanded(
              child: FutureBuilder<List<SettingsListData>>(
                future: SettingsListData.getSettingsList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final settingsList = snapshot.data ?? [];

                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: settingsList.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      // 2. The theme UI is now built using the controller.
                      if (index == 0) {
                        return _controller.buildThemePopupMenu(context);
                      }

                      // 3. All other items have a single, clean onTap callback.
                      return InkWell(
                        onTap: () => _controller.onSettingsItemTapped(context, index),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    settingsList[index].titleTxt,
                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(settingsList[index].iconData, color: AppTheme.secondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
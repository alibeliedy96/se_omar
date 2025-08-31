import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/logic/controllers/theme_provider.dart';
import 'package:mr_omar/modules/bottom_tab/components/tab_button_ui.dart';
import 'package:mr_omar/widgets/common_card.dart';

import '../explore/view/home_explore/home_explore.dart';
import '../myTrips/presentation/view/my_trips_screen.dart';
import '../profile/view/profile/profile_screen.dart';

class BottomTabScreen extends StatefulWidget {
  final BottomBarType initialTab;

  const BottomTabScreen({
    Key? key,
    this.initialTab = BottomBarType.explore,
  }) : super(key: key);

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  late BottomBarType bottomBarType;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);


    bottomBarType = widget.initialTab;
    _indexView = Container();

    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _isFirstTime = false;
      _indexView = _getScreenForTab(bottomBarType);
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60 + MediaQuery.of(context).padding.bottom,
        child: getBottomBarUI(bottomBarType),
      ),
      body: _isFirstTime
          ? const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      )
          : _indexView,
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        setState(() {
          _indexView = _getScreenForTab(tabType);
        });
      });
    }
  }

  Widget _getScreenForTab(BottomBarType tabType) {
    if (tabType == BottomBarType.explore) {
      return HomeExploreScreen(animationController: _animationController);
    } else if (tabType == BottomBarType.trips) {
      return MyTripsScreen(animationController: _animationController);
    } else if (tabType == BottomBarType.profile) {
      return ProfileScreen(animationController: _animationController);
    }
    return Container();
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return GetBuilder<ThemeController>(
      builder: (_) {
        return CommonCard(
          color: AppTheme.backgroundColor,
          radius: 0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  TabButtonUI(
                    icon: Icons.search,
                    isSelected: tabType == BottomBarType.explore,
                    text: Loc.alized.explore,
                    onTap: () {
                      tabClick(BottomBarType.explore);
                    },
                  ),
                  TabButtonUI(
                    icon: FontAwesomeIcons.compass,
                    isSelected: tabType == BottomBarType.trips,
                    text: Loc.alized.trips,
                    onTap: () {
                      tabClick(BottomBarType.trips);
                    },
                  ),
                  TabButtonUI(
                    icon: FontAwesomeIcons.user,
                    isSelected: tabType == BottomBarType.profile,
                    text: Loc.alized.profile,
                    onTap: () {
                      tabClick(BottomBarType.profile);
                    },
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }
}

enum BottomBarType { explore, trips, profile }

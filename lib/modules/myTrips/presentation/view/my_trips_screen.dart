import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/bottom_top_move_animation_view.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'cancelled_list_view.dart';
import 'confirmed_list_view.dart';
import 'finish_trip_view.dart';
import 'upcoming_list_view.dart';

class MyTripsScreen extends StatefulWidget {
  final AnimationController animationController;

  const MyTripsScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    widget.animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getAppBar(),
          ),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ConfirmedListView(
                  type: "confirmed",
                  animationController: widget.animationController,
                ),
                UpcomingListView(
                  type: "pending",
                  animationController: widget.animationController,
                ),
                FinishTripView(
                  animationController: widget.animationController,
                ),
                CancelledListView(
                  animationController: widget.animationController,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: 36,
        child: TabBar(
          padding: EdgeInsets.zero,
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          tabs: [
            _tabItem(Loc.alized.confirmed, 0),
            _tabItem(Loc.alized.upcoming, 1),
            _tabItem(Loc.alized.finished, 2),
            _tabItem(Loc.alized.cancelled, 3),
          ],
        ),
      ),
    );
  }


  Widget _tabItem(String text, int index) {
    final isSelected = _tabController.index == index;
    return Tab(
      iconMargin: EdgeInsets.zero,
      child: AnimatedBuilder(
        animation: _tabController.animation!,
        builder: (context, _) {
          final isActive = _tabController.index == index;
          return Text(
            text,
            style: TextStyles(context).regular().copyWith(
              fontWeight: FontWeight.w600,
              color: isActive
                  ? AppTheme.primaryColor
                  : AppTheme.secondaryTextColor,
            ),
          );
        },
      ),
    );
  }

  Widget _getAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 28, right: 14),
      child: Text(
        Loc.alized.my_trips,
        style: TextStyles(context).bold().copyWith(fontSize: 22),
      ),
    );
  }
}

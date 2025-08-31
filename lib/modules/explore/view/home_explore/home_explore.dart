import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/bottom_top_move_animation_view.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/common_search_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../../../utils/uti.dart';
import 'units_list_view_page.dart';
import '../../logic/explore_cubit/explore_cubit.dart';
import '../../title_view.dart';
import 'home_explore_controller.dart';
import 'home_explore_slider_view.dart';


class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;
  const HomeExploreScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen> with TickerProviderStateMixin {
  late final HomeExploreController _controller;
  late final ScrollController _scrollController;
  late final AnimationController _sliderAnimationController;
  double _sliderImageHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = HomeExploreController();
    _controller.addListener(_refresh);

    _sliderAnimationController = AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    _scrollController = ScrollController(initialScrollOffset: 0.0);

    _scrollController.addListener(() {
      if (mounted) {
        if (_scrollController.offset < 0) {
          _sliderAnimationController.animateTo(0.0);
        } else if (_scrollController.offset > 0.0 && _scrollController.offset < _sliderImageHeight) {
          if (_scrollController.offset < ((_sliderImageHeight / 1.5))) {
            _sliderAnimationController.animateTo((_scrollController.offset / _sliderImageHeight));
          } else {
            _sliderAnimationController.animateTo((_sliderImageHeight / 1.5) / _sliderImageHeight);
          }
        }
      }
    });
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    _sliderAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sliderImageHeight = MediaQuery.of(context).size.width * 1.3;

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child:BlockBuilderWidget<ExploreCubit, ExploreApiTypes>(
        types: const [ExploreApiTypes.loadInitialData ],
        body: (_) {
          if((_controller.sliders.isEmpty)&&(_controller.units.isEmpty)) {
            return  UTI.errorWidget();
          }else{
            return _buildContent( loading: false);
          }

        },
        error: (_) => UTI.errorWidget(),
        loading: (_) => _buildContent( loading: true),
      ),
    );
  }



  Widget _buildContent({required bool loading}) {
    return Skeletonizer(
      enabled: loading,
      child: Stack(
        children: [

          Container(
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 2, // 0 for Title, 1 for the list of units
              padding: EdgeInsets.only(top: _sliderImageHeight + 32, bottom: 16),
              itemBuilder: (context, index) {
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / 2) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                if (index == 0) {
                  return _controller.units.isEmpty?TitleView(
                    titleTxt: Loc.alized.best_deal,
                    animationController: widget.animationController,
                    animation: animation,click: () {  },
                  ):const SizedBox();
                } else {
                  return _buildUnitsList();
                }
              },
            ),
          ),
          _sliderUI(),
          _gradientUI(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: searchUI(),
          )
        ],
      ),
    );
  }

  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _sliderAnimationController,
        builder: (BuildContext context, Widget? child) {
          var opacity = 1.0 - (_sliderAnimationController.value > 0.64 ? 1.0 : _sliderAnimationController.value);
          return SizedBox(
            height: _sliderImageHeight * (1.0 - _sliderAnimationController.value),
            child: HomeExploreSliderView(
              opValue: opacity,
              sliders: _controller.sliders, // Pass slider data from controller
              click: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _gradientUI() {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withValues(alpha:  0.4), Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildUnitsList() {
    final units = _controller.units;
    if(units.isEmpty)
      {
        return const SizedBox.shrink();
      }
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: units.length,
      itemBuilder: (context, index) {
        var animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: widget.animationController, curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)),
        );

        final hotelData = units[index];
        return UnitsListViewPage(
          callback: () => _controller.navigateToUnitDetails(context, units[index]),
          unitData: hotelData,
          animation: animation,
          animationController: widget.animationController,
        );
      },
    );
  }

  Widget searchUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(38)),
          onTap: () => _controller.navigateToSearch(context),
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.magnifyingGlass,
            enabled: false,
            text: Loc.alized.where_are_you_going,
          ),
        ),
      ),
    );
  }
}
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/unit_details/domain/models/unit_details_response.dart';
import 'package:mr_omar/modules/unit_details/review_data_view.dart';
import 'package:mr_omar/modules/unit_details/view/unit_details_controller.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:mr_omar/widgets/common_button.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../models/hotel_list_data.dart';
import '../../../utils/base_cubit/block_builder_widget.dart';
import '../../../utils/uti.dart';
import '../../../widgets/base_cached_image_widget.dart';
import '../logic/unit_details_cubit/unit_details_cubit.dart';
import 'widgets/unit_images_list.dart';
import '../rating_view.dart';

class HotelDetails extends StatefulWidget {
  final String unitId  ;

  const HotelDetails({Key? key, required this.unitId,  }) : super(key: key);
  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  late final UnitDetailsController _controller;
  // var hoteltext1 =
  //     "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum...";
  // var hoteltext2 =
  //     "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum";
  bool isFav = false;
  bool isReadless = false;
  late AnimationController animationController;
  var imageHieght = 0.0;
  late AnimationController _animationController;
  void _refresh() {
    if (mounted) setState(() {});
  }
  @override
  void initState() {
    _controller = UnitDetailsController();
    _controller.addListener(_refresh);
    _controller.init(widget.unitId);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHieght) {
          // we need around half scrolling values
          if (scrollController.offset < ((imageHieght / 1.2))) {
            _animationController
                .animateTo((scrollController.offset / imageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHieght / 1.2) / imageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlockBuilderWidget<UnitDetailsCubit, UnitDetailsApiTypes>(
        types: const [UnitDetailsApiTypes.unitDetails ],
        body: (_) {
          if(_controller.unitDetails ==null) {
            return  UTI.errorWidget();
          }else{
            return _buildContent(context, loading: false);
          }

        },
        error: (_) => UTI.errorWidget(),
        loading: (_) => _buildContent(context, loading: true),
      ) ,
    );
  }

  Widget _buildContent(BuildContext context, {required bool loading}) {
    final unit = _controller.unitDetails!;
    return Skeletonizer(
      enabled: loading,
      child: Stack(
        children: [
          CommonCard(
            radius: 0,
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHieght),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  // Hotel title and animation view
                  child: getUnitDetails(isInList: true,unit:unit),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          Loc.alized.summary,
                          style: TextStyles(context).bold().copyWith(
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? unit.description??"" : unit.description??"",
                          style: TextStyles(context).description().copyWith(
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless
                              ? Loc.alized.read_more
                              : Loc.alized.less,
                          style: TextStyles(context).regular().copyWith(
                              color: AppTheme.primaryColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  // overall rating view
                  child: RatingView(unit: unit),
                ),
                _getPhotoReviewUi(Loc.alized.room_photo, Loc.alized.view_all,
                  Icons.arrow_forward, () {},
                ),

                // Hotel inside photo view
                  UnitImagesList(images:unit.images),
                _getPhotoReviewUi(Loc.alized.reviews, Loc.alized.view_all,
                    Icons.arrow_forward, () {
                      NavigationServices(context).gotoReviewsListScreen();
                    }),

                // feedback&Review data view
                for (var i = 0; i < (unit.reviews?.length ?? 0); i++)
                  ReviewsView(
                    reviewsList: unit.reviews![i],
                    animation: animationController,
                    animationController: animationController,
                    callback: () {},
                  ),

                const SizedBox(
                  height: 16,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(
                        Localfiles.mapImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 34, right: 10),
                      child: CommonCard(
                        color: AppTheme.primaryColor,
                        radius: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FontAwesomeIcons.mapPin,
                            color: Theme.of(context).colorScheme.surface,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: CommonButton(
                    buttonText: Loc.alized.book_now,
                    onTap: () {
                      NavigationServices(context)
                          .gotoBookScreen(unit:unit);
                    },
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),

          // backgrouund image and Hotel name and thier details and more details animation view
          _backgroundImageUI(unit),

          // Arrow back Ui
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                children: [
                  _getAppBarUi(Theme.of(context).disabledColor.withValues(alpha:0.4),
                      Icons.arrow_back, AppTheme.backgroundColor, () {
                        if (scrollController.offset != 0.0) {
                          scrollController.animateTo(0.0,
                              duration: const Duration(milliseconds: 480),
                              curve: Curves.easeInOutQuad);
                        } else {
                          Navigator.pop(context);
                        }
                      }),
                  const Expanded(
                    child: SizedBox(),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _getAppBarUi(
      Color color, IconData icon, Color iconColor, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: iconColor),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _getPhotoReviewUi(
      String title, String view, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyles(context).bold().copyWith(
                fontSize: 14,
              ),
            ),
          ),
          // Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          //     onTap: onTap,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 8),
          //       child: Row(
          //         children: [
          //           Text(
          //             view,
          //             textAlign: TextAlign.left,
          //             style: TextStyles(context).bold().copyWith(
          //                   fontSize: 14,
          //                   color: Theme.of(context).primaryColor,
          //                 ),
          //           ),
          //           SizedBox(
          //             height: 38,
          //             width: 26,
          //             child: Icon(
          //               icon,
          //               //Icons.arrow_forward,
          //               size: 18,
          //               color: Theme.of(context).primaryColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _backgroundImageUI(UnitDetailsData unit) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          var opecity = 1.0 -
              (_animationController.value >= ((imageHieght / 1.2) / imageHieght)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHieght * (1.0 - _animationController.value),
            child: Stack(
              children: [
                IgnorePointer(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child:unit.images != null &&
                              unit.images!.isNotEmpty
                              ? CachedImageWidget(imageUrl: unit.images!.first.imagePath ?? "", fit: BoxFit.cover,)

                              : Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, size: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opecity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                              ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      child: getUnitDetails(unit: unit),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 16),
                                      child: CommonButton(
                                          buttonText: Loc.alized.book_now,
                                          onTap: () {
                                            NavigationServices(context)
                                                .gotoBookScreen(unit:unit);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                              ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha:0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(38)),
                                    onTap: () {
                                      try {
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    5,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.fastOutSlowIn);
                                      } catch (_) {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            Loc.alized.more_details,
                                            style: TextStyles(context)
                                                .bold()
                                                .copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getUnitDetails({bool isInList = false, required UnitDetailsData unit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.name??"",
                textAlign: TextAlign.left,
                style: TextStyles(context).bold().copyWith(
                  fontSize: 22,
                  color: isInList ? AppTheme.fontcolor : Colors.white,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child:  Text(
                      "${Loc.alized.number_of_beds}: ${unit.bedrooms ?? 0}",
                      style:
                      TextStyles(context).description().copyWith(
                          fontSize: 14,
                          color: isInList
                              ? Theme.of(context).disabledColor.withValues(alpha:0.5)
                              : Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [

                  Expanded(
                    child: Text(
                      Loc.alized.kitchen_and_bathroom_available,
                      overflow:
                      TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles(context)
                          .description()
                          .copyWith(
                          fontSize: 12,
                          color: isInList
                              ? Theme.of(context).disabledColor.withValues(alpha:0.5)
                              : Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              isInList
                  ? const SizedBox()
                  : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Helper.ratingStar(rating: double.tryParse(unit.ratingStatistics?.averages?.overall??"0.0")??0.0),
                    Text(
                      unit.ratingStatistics?.totalReviews??"",
                      style: TextStyles(context).regular().copyWith(
                        fontSize: 14,
                        color: isInList
                            ? Theme.of(context)
                            .disabledColor
                            .withValues(alpha: 0.5)
                            : Colors.white,
                      ),
                    ),
                    Text(
                      Loc.alized.reviews,
                      style: TextStyles(context).regular().copyWith(
                        fontSize: 14,
                        color: isInList
                            ? Theme.of(context).disabledColor
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${Loc.alized.egp} ${(double.tryParse(unit.monthlyPricing?[0].dailyPrice??""))?.toStringAsFixed(0) ?? "0.0"}",
              textAlign: TextAlign.left,
              style: TextStyles(context).bold().copyWith(
                fontSize: 22,
                color: isInList
                    ? Theme.of(context).textTheme.bodyLarge!.color
                    : Colors.white,
              ),
            ),
            Text(
              Loc.alized.per_night,
              style: TextStyles(context).regular().copyWith(
                fontSize: 14,
                color: isInList
                    ? Theme.of(context).disabledColor
                    : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
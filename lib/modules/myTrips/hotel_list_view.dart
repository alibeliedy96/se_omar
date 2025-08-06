import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/models/hotel_list_data.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListView(
      {Key? key,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: Column(
          children: [
            isShowDate
                ? Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Helper.getDateText(hotelData.date!)}, ',
                          style: TextStyles(context)
                              .regular()
                              .copyWith(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            Helper.getRoomText(hotelData.roomData!),
                            style: TextStyles(context)
                                .regular()
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            hotelData.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotelData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .bold()
                                          .copyWith(fontSize: 22),
                                    ),

                                    Text(
                                      "${Loc.alized.number_of_beds}: ${hotelData.subTxt}",
                                      style:
                                      TextStyles(context).description().copyWith(
                                        fontSize: 14,
                                      ),
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
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Helper.ratingStar(),
                                          Text(
                                            " ${hotelData.reviews}",
                                            style: TextStyles(context)
                                                .description(),
                                          ),
                                          Text(
                                            Loc.alized.reviews,
                                            style: TextStyles(context)
                                                .description(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, top: 8, left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${hotelData.perNight}",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .bold()
                                        .copyWith(fontSize: 22),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.find<Loc>().isRTL ? 2.0 : 0.0),
                                    child: Text(
                                      Loc.alized.per_night,
                                      style: TextStyles(context).description(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            onTap: () {
                              try {
                                callback();
                              } catch (_) {}
                            }),
                      ),
                    ),
                    // Positioned(
                    //   top: 8,
                    //   right: 8,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Theme.of(context).colorScheme.surface,
                    //         shape: BoxShape.circle),
                    //     child: Material(
                    //       color: Colors.transparent,
                    //       child: InkWell(
                    //         borderRadius: const BorderRadius.all(
                    //           Radius.circular(32.0),
                    //         ),
                    //         onTap: () {},
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Icon(
                    //             Icons.favorite_border,
                    //             color: Theme.of(context).primaryColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

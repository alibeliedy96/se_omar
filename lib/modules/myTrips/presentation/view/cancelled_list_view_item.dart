import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';
import '../../../../widgets/base_cached_image_widget.dart';
import '../../domain/models/get_reservations_response.dart';

class CancelledListViewItem extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final ReservationsData reservationsData;
  final AnimationController animationController;
  final Animation<double> animation;

  const CancelledListViewItem({
    Key? key,
    required this.reservationsData,
    required this.animationController,
    required this.animation,
    required this.callback,
    this.isShowDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 14),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 0.90,
                        child: reservationsData.unit?.images != null &&
                            reservationsData.unit!.images!.isNotEmpty
                            ? CachedImageWidget(
                          imageUrl: reservationsData
                              .unit!.images!.first.imagePath ??
                              "",
                          fit: BoxFit.cover,
                        )
                            : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 40),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width >= 360 ? 12 : 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// unit name
                              Text(
                                reservationsData.unit?.name ?? "",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyles(context).bold().copyWith(
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),

                              /// number of beds
                              Text(
                                "${Loc.alized.number_of_beds}: ${reservationsData.unit?.bedrooms ?? 0}",
                                style: TextStyles(context)
                                    .description()
                                    .copyWith(fontSize: 14),
                              ),

                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  Loc.alized
                                                      .kitchen_and_bathroom_available,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyles(context)
                                                      .description()
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Helper.ratingStar(
                                                rating: double.tryParse(
                                                  reservationsData
                                                      .unit
                                                      ?.ratingStatistics
                                                      ?.averages
                                                      ?.overall ??
                                                      "0.0",
                                                ) ??
                                                    0.0,
                                              ),
                                              Text(
                                                "(${reservationsData.unit?.ratingStatistics?.totalReviews ?? ""})",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyles(context)
                                                    .description()
                                                    .copyWith(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// price per night
                                    FittedBox(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${Loc.alized.egp} ${(double.tryParse(reservationsData.unit?.monthlyPricing?[0].dailyPrice ?? ""))?.toStringAsFixed(0) ?? "0.0"}",
                                              textAlign: TextAlign.left,
                                              style: TextStyles(context)
                                                  .bold()
                                                  .copyWith(fontSize: 14),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: Get.find<Loc>().isRTL
                                                    ? 2.0
                                                    : 0.0,
                                              ),
                                              child: Text(
                                                Loc.alized.per_night,
                                                style: TextStyles(context)
                                                    .description()
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          callback();
                        } catch (_) {}
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

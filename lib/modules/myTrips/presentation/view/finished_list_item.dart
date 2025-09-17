import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';

import '../../../../widgets/base_cached_image_widget.dart';
import '../../domain/models/get_reservations_response.dart';

class FinishedReservationListViewItem extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final ReservationsData reservationsData;
  final AnimationController animationController;
  final Animation<double> animation;

  const FinishedReservationListViewItem(
      {Key? key,
        required this.reservationsData,
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
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          onTap: () {
            try {
              callback();
            } catch (_) {}
          },
          child: Row(
            children: [
              isShowDate ? getUI(context) : const SizedBox(),
              CommonCard(
                color: AppTheme.backgroundColor,
                radius: 16,
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: CachedImageWidget(
                        imageUrl:
                       reservationsData.unit?.primaryImage?.imageUrl ?? ""
                          ,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              !isShowDate ? getUI(context) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUI(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: EdgeInsets.only(
            left: !isShowDate ? 16 : 8,
            top: 8,
            bottom: 8,
            right: isShowDate ? 16 : 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
          isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              reservationsData.unit?.name ?? "",
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).bold().copyWith(
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${Loc.alized.number_of_beds}: ${reservationsData.unit?.bedrooms ?? ""}",
              style: TextStyles(context).description().copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              Helper.getDateText(
                reservationsData.checkInDate ?? "",
                reservationsData.checkOutDate ?? "",
              ),
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).regular().copyWith(
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: FittedBox(
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: isShowDate
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Helper.ratingStar(
                        rating: double.tryParse(
                          reservationsData.unit?.ratingStatistics?.averages
                              ?.overall ??
                              "",
                        ) ??
                            0.0,
                      ),
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            "${Loc.alized.egp} ${(double.tryParse(reservationsData.unit?.monthlyPricing?[0].dailyPrice ?? ""))?.toStringAsFixed(0) ?? "0.0"}",
                            textAlign: TextAlign.left,
                            style: TextStyles(context).regular().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Get.find<Loc>().isRTL ? 4.0 : 2.0),
                            child: Text(
                              Loc.alized.per_night,
                              style: TextStyles(context).description().copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/helper.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/models/hotel_list_data.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import 'package:mr_omar/modules/login/logic/auth_cubit/auth_cubit.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';

import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../../../widgets/base_cached_image_widget.dart';
import '../../domain/models/get_reservations_response.dart';
import '../../logic/reservations_cubit/reservations_cubit.dart';

class UpcomingListItem extends StatelessWidget {
  final bool isShowDate;
  final bool isUpcoming;
  final VoidCallback callback;
  final ReservationsData reservationsData;
  final AnimationController animationController;
  final Animation<double> animation;

  const UpcomingListItem({
    Key? key,
    required this.reservationsData,
    required this.animationController,
    required this.animation,
    required this.callback,
    this.isShowDate = false,
    required this.isUpcoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        try {
          callback();
        } catch (_) {}
      },
      child: ListCellAnimationView(
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
                          Expanded(
                            child: Text(
                              '${Helper.getDateText(reservationsData.checkInDate!, reservationsData.checkOutDate!)}, ',
                              style: TextStyles(context)
                                  .regular()
                                  .copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              Helper.getRoomText(
                                  bedrooms: reservationsData.unit?.bedrooms ?? "",
                                  maxGuests:
                                      reservationsData.unit?.maxGuests ?? ""),
                              style: TextStyles(context)
                                  .regular()
                                  .copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
                            child: CachedImageWidget(
                              imageUrl:
                                  reservationsData.unit?.primaryImage?.imageUrl ??
                                      "",
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
                                        reservationsData.unit?.name ?? "",
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .bold()
                                            .copyWith(fontSize: 22),
                                      ),
                                      Text(
                                        "${Loc.alized.number_of_beds}: ${reservationsData.unit?.bedrooms ?? ""}",
                                        style: TextStyles(context)
                                            .description()
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              Loc.alized
                                                  .kitchen_and_bathroom_available,
                                              overflow: TextOverflow.ellipsis,
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
                                            Helper.ratingStar(
                                                rating: double.tryParse(
                                                        reservationsData
                                                                .unit
                                                                ?.ratingStatistics
                                                                ?.averages
                                                                ?.overall ??
                                                            "") ??
                                                    0.0),
                                            Text(
                                              " ${reservationsData.unit?.ratingStatistics?.totalReviews ?? ""}",
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
                                      "${Loc.alized.egp} ${(double.tryParse(reservationsData.unit?.monthlyPricing?[0].dailyPrice ?? ""))?.toStringAsFixed(0) ?? "0.0"}",
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
                      if (isUpcoming == true)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              elevation: 4,
                            ),
                            icon: const Icon(Icons.cancel, size: 18),
                            label: Text(
                              Loc.alized.cancel,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text(
                                      Loc.alized.cancel_reservation,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      AuthCubit.get()
                                              .settingData
                                              ?.cancellationPolicy ??
                                          "",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(),
                                        child: Text(Loc.alized.no),
                                      ),
                                      BlockBuilderWidget<ReservationsCubit, ReservationsApiTypes>(
                                        types: const [ReservationsApiTypes.cancelReservations],
                                        loading: (_) => CircularProgressIndicator(
                                          color: AppTheme.primaryColor,
                                        ),
                                        body: (_) => _cancelBtn(ctx),
                                        error: (_) => _cancelBtn(ctx),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _cancelBtn(BuildContext ctx) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {

        ReservationsCubit.get().cancelReservations(context: ctx, id: reservationsData.id.toString());
      },
      child: Text(Loc.alized.yes_cancel),
    );
  }
}

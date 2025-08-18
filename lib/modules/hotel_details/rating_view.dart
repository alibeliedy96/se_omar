import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/hotel_details/domain/models/unit_details_response.dart';
import 'package:mr_omar/widgets/common_card.dart';
import '../../models/hotel_list_data.dart';

class RatingView extends StatelessWidget {
  final UnitDetailsData   unit;

  const RatingView({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    "${double.tryParse(unit.ratingStatistics?.averages?.overall??"")??0.0}",
                    textAlign: TextAlign.left,
                    style: TextStyles(context).bold().copyWith(
                          fontSize: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Loc.alized.overall_rating,
                          textAlign: TextAlign.left,
                          style: TextStyles(context).regular().copyWith(
                                // fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.8),
                              ),
                        ),
                        // SmoothStarRating(
                        //   allowHalfRating: true,
                        //   starCount: 5,
                        //   rating: unit.rating,
                        //   size: 16,
                        //   color: Theme.of(context).primaryColor,
                        //   borderColor: Theme.of(context).primaryColor,
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            getBarUI(Loc.alized.room, double.tryParse(unit.ratingStatistics?.averages?.room??"")??0.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI(Loc.alized.service, double.tryParse(unit.ratingStatistics?.averages?.service??"")??0.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI(Loc.alized.location, double.tryParse(unit.ratingStatistics?.averages?.location??"")??0.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI(Loc.alized.price, double.tryParse(unit.ratingStatistics?.averages?.pricing??"")??0.0, context),
          ],
        ),
      ),
    );
  }

  Widget getBarUI(String text, double percent, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyles(context).regular().copyWith(
                  // fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Theme.of(context).disabledColor.withOpacity(0.8),
                ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: percent.toInt(),
                child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: SizedBox(
                      height: 4,
                      child: CommonCard(
                        color: AppTheme.primaryColor,
                        radius: 8,
                      ),
                    )),
              ),
              Expanded(
                flex: 100 - percent.toInt(),
                child: const SizedBox(),
              )
            ],
          ),
        )
      ],
    );
  }
}

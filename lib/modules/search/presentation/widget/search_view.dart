import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';
import '../../../../constants/helper.dart';
import '../../../../language/app_localizations.dart';
import '../../../../routes/route_names.dart';
import '../../../../widgets/base_cached_image_widget.dart';
import '../../domain/models/search_response.dart';

class SearchView extends StatelessWidget {
  final SearchData unit;
  final AnimationController animationController;
  final Animation<double> animation;

  const SearchView({
    Key? key,
    required this.unit,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationServices(context).gotoHotelDetails(unitId: unit.id.toString());
      },
      child: ListCellAnimationView(
        animation: animation,
        animationController: animationController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 0.74,
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: unit.images != null &&
                          unit.images!.isNotEmpty
                          ? CachedImageWidget(imageUrl: unit.images?.primaryImageUrl ?? "", fit: BoxFit.cover,)

                          : Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image, size: 40),
                      ) ,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              unit.name ?? "Unknown Unit",
                              style: TextStyles(context).bold(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            // Text(
                            //   "${unit.bedrooms} BR · ${unit.bathrooms} Bath · ${unit.maxGuests} Guests",
                            //   style: TextStyles(context)
                            //       .regular()
                            //       .copyWith(fontSize: 12, color: Colors.grey),
                            // ),
                            Text(
                              "${Loc.alized.number_of_beds}: ${unit.bedrooms ?? 0}",
                              style: TextStyles(context)
                                  .description()
                                  .copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                Helper.ratingStar(rating: double.parse(unit.ratingStatistics?.averages?.overall??"0.0")),

                                Text(
                                  "(${unit.ratingStatistics?.totalReviews??""})",
                                  overflow:
                                  TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyles(context)
                                      .description()
                                      .copyWith(fontSize: 12),
                                )
                              ],
                            ),

                            const Spacer(),
                            if (unit.monthlyPricing != null &&
                                unit.monthlyPricing!.isNotEmpty)
                              Text(
                                "${unit.monthlyPricing?[0].dailyPrice??"0"} ${Loc.alized.egp}" ,
                                style: TextStyles(context)
                                    .bold()
                                    .copyWith(color: AppTheme.primaryColor),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

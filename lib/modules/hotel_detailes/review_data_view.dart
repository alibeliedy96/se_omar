import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/models/hotel_list_data.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/list_cell_animation_view.dart';

class ReviewsView extends StatelessWidget {
  final VoidCallback callback;
  final HotelListData reviewsList;
  final AnimationController animationController;
  final Animation<double> animation;

  const ReviewsView({
    Key? key,
    required this.reviewsList,
    required this.animationController,
    required this.animation,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      yTranslation: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 48,
                    child: CommonCard(
                      radius: 8,
                      color: AppTheme.whiteColor,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            reviewsList.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewsList.titleTxt,
                      style: TextStyles(context).bold().copyWith(
                            fontSize: 14,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          Loc.alized.last_update,
                          style: TextStyles(context).description().copyWith(
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                        Text(
                          reviewsList.dateTxt,
                          style: TextStyles(context).description().copyWith(
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "(${reviewsList.rating})",
                          style: TextStyles(context).regular().copyWith(
                                fontWeight: FontWeight.w100,
                              ),
                        ),
                        //   SmoothStarRating(
                        //     allowHalfRating: true,
                        //     starCount: 5,
                        //     rating: reviewsList.rating / 2,
                        //     size: 16,
                        //     color: Theme.of(context).primaryColor,
                        //     borderColor: Theme.of(context).primaryColor,
                        //   ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                reviewsList.subTxt,
                style: TextStyles(context).description().copyWith(
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),

            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}

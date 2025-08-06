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

class HotelListViewData extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListViewData(
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
                      child: Image.asset(
                        hotelData.imagePath,
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
              hotelData.titleTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).bold().copyWith(
                    fontSize: 16,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${Loc.alized.number_of_beds}: ${hotelData.subTxt}",
              style: TextStyles(context).description().copyWith(
                    fontSize: 12,
                  ),
            ),
            Text(
              Helper.getDateText(hotelData.date!),
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).regular().copyWith(
                    fontSize: 12,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              Helper.getRoomText(hotelData.roomData!),
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
                    
                      Helper.ratingStar(),
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            "\$${hotelData.perNight}",
                            textAlign: TextAlign.left,
                            style: TextStyles(context).regular().copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
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

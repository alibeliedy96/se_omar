import 'package:mr_omar/language/app_localizations.dart';

class PopularFilterListData {
  String titleTxt;
  bool isSelected;

  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<PopularFilterListData> popularFList = [
    PopularFilterListData(
      titleTxt: Loc.alized.free_breakfast,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.free_Parking,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.pool_text,
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.pet_friendlly,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.free_wifi,
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: Loc.alized.all_text,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.apartment,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.home_text,
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.villa_data,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.hotel_data,
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: Loc.alized.resort_data,
      isSelected: false,
    ),
  ];
}

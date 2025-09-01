import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/search/presentation/widget/search_view.dart';
import 'package:mr_omar/widgets/common_appbar_view.dart';
import 'package:mr_omar/widgets/common_card.dart';
import 'package:mr_omar/widgets/common_search_bar.dart';
import 'package:mr_omar/widgets/remove_focuse.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../models/hotel_list_data.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../../../utils/custom_smart_refresher.dart';
import '../../../../utils/uti.dart';
import '../../logic/search_cubit/search_cubit.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  final String searchKey;
  const SearchScreen({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<HotelListData> lastsSearchesList = HotelListData.lastsSearchesList;

  late AnimationController animationController;


  late final SearchListController _controller;



  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller = SearchListController();
    _controller.init(searchKey: widget.searchKey);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomSmartRefresher(

          onRefresh: () {
            return  _controller.onRefresh();
          },
          onLoadMore: () {
            return _controller.onLoadMore();
          },
          isLastPage: () => _controller.isLastPage,
          child: SingleChildScrollView(
            child: BlockBuilderWidget<SearchCubit, SearchApiTypes>(
              types: const [SearchApiTypes.search],
              // The body and loading states now call the same builder method
              body: (_) {
                final notifications = _controller.reservations;
                if (  notifications.isEmpty){
                  return UTI.errorWidget();
                }else {
                  return _searchList( context, loading: false);
                }
              },
              error: (_) => UTI.errorWidget(),
              loading: (_) => _searchList(context,  loading: true),
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchList(BuildContext context, {required bool loading}) {
    return Skeletonizer(
      enabled: loading,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: Loc.alized.search_hotel,
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 16),
                        child: CommonCard(
                          color: AppTheme.backgroundColor,
                          radius: 36,
                          child: SearchTextFieldWidget(

                             controller: _controller.searchController,
                             onChanged: (searchKey) {
                               _controller.init(searchKey: _controller.searchController.text);
                             },
                             hintText: Loc.alized.where_are_you_going,
                          ),
                        ),
                      ),

                    ] +
                    getPList() +
                    [
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16,
                      )
                    ],
              ),
            ),
          ],
        ),
    );
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    final reservations = _controller.reservations;
    var cout = 0;
    const columCount = 2;

    for (var i = 0; i < reservations.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var j = 0; j < columCount; j++) {
        try {
          final unit = reservations[cout];
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / reservations.length) * cout, 1.0,
                  curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          listUI.add(Expanded(
            child: SearchView(
              unit: unit,
              animation: animation,
              animationController: animationController,
            ),
          ));
          cout += 1;
        } catch (_) {}
      }
      noList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: listUI),
        ),
      );
    }
    return noList;
  }

}

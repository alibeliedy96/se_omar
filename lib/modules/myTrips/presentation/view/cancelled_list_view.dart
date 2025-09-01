import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../../../utils/custom_smart_refresher.dart';
import '../../../../utils/uti.dart';
import '../../logic/reservations_cubit/reservations_cubit.dart';
import '../controller/reservations_controller.dart';
import 'cancelled_list_view_item.dart';


class CancelledListView extends StatefulWidget {
  final AnimationController animationController;

  const CancelledListView({Key? key, required this.animationController})
      : super(key: key);
  @override
  State<CancelledListView> createState() => _CancelledListViewState();
}

class _CancelledListViewState extends State<CancelledListView> {
  late final ReservationsController _controller;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    widget.animationController.forward();
    _controller = ReservationsController();
    _controller.init(status: "cancelled");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return CustomSmartRefresher(

      onRefresh: () {
        return  _controller.onRefresh(status: "cancelled");
      },
      onLoadMore: () {
        return _controller.onLoadMore(status: "cancelled");
      },
      isLastPage: () => _controller.isLastPage,
      child: SingleChildScrollView(
        child: BlockBuilderWidget<ReservationsCubit, ReservationsApiTypes>(
          types: const [ReservationsApiTypes.reservations],
          // The body and loading states now call the same builder method
          body: (_) {
            final notifications = _controller.reservations;
            if (  notifications.isEmpty){
              return UTI.errorWidget();
            }else {
              return _buildListView(  loading: false);
            }
          },
          error: (_) => UTI.errorWidget(),
          loading: (_) => _buildListView(  loading: true),
        ),
      ),
    );
  }

  Widget _buildListView({required bool loading}) {
    return Skeletonizer(
      enabled: loading,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      itemCount: _controller.reservations.length,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var count = _controller.reservations.length > 10 ? 10 : _controller.reservations.length;
        var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / count) * index, 1.0,
                curve: Curves.fastOutSlowIn)));
        widget.animationController.forward();
        //Favorites hotel data list and UI View
        return CancelledListViewItem(
          callback: () {
            NavigationServices(context)
                .gotoHotelDetails(unitId:_controller.reservations[index].unit!.id.toString());
          },
          reservationsData: _controller.reservations[index] ,
          animation: animation,
          animationController: widget.animationController,
        );
      },
        ),
    );
  }
}

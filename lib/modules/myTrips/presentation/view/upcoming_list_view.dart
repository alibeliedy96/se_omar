import 'package:flutter/material.dart';
import 'package:mr_omar/modules/myTrips/presentation/view/upcoming_list_item.dart';
import 'package:mr_omar/routes/route_names.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../models/hotel_list_data.dart';
import '../../../../utils/base_cubit/block_builder_widget.dart';
import '../../../../utils/custom_smart_refresher.dart';
import '../../../../utils/uti.dart';
import '../../logic/reservations_cubit/reservations_cubit.dart';
import '../controller/reservations_controller.dart';

class UpcomingListView extends StatefulWidget {
  final AnimationController animationController;
  final String type;
  const UpcomingListView({Key? key, required this.animationController, required this.type,   })
      : super(key: key);
  @override
  State<UpcomingListView> createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> {

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
    _controller.init(status: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomSmartRefresher(

      onRefresh: () {
      return  _controller.onRefresh(status: widget.type);
      },
      onLoadMore: () {
       return _controller.onLoadMore(status: widget.type);
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
      itemCount: _controller.reservations.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var count = _controller.reservations.length > 10 ? 10 : _controller.reservations.length;
        var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / count) * index, 1.0,
                curve: Curves.fastOutSlowIn)));
        widget.animationController.forward();
        //Upcoming UI view and hotel list
        return UpcomingListItem(
          callback: () {
            NavigationServices(context)
                .gotoHotelDetails(unitId:_controller.reservations[index].unit!.id.toString());
          },
          reservationsData: _controller.reservations[index],
          animation: animation,
          animationController: widget.animationController,
          isShowDate: true,
        );
      },
        ),
    );
  }
}

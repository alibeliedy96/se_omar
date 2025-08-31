
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../language/app_localizations.dart';



class CustomSmartRefresher extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  final Future Function() onLoadMore;
  final bool Function() isLastPage;
  final bool enablePullDown;
  final bool enablePullUp;

  const CustomSmartRefresher({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoadMore,
    required this.isLastPage,
    this.enablePullDown = true,
    this.enablePullUp = true,
  });

  @override
  State<CustomSmartRefresher> createState() => _CustomSmartRefresherState();
}

class _CustomSmartRefresherState extends State<CustomSmartRefresher> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        await widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await widget.onLoadMore();
        _refreshController.loadComplete();
      },
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      // footer: UTI.footerForLoading(),
      footer: customFooter2(),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 5),
          widget.child,
        ],
      ),
    );
  }

  Widget customFooter2() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget? body;
        if (mode == LoadStatus.loading) {
          body =   CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          );
        } else if (widget.isLastPage()) {
          body = Text(
            Loc.alized.no_more_data,
            style: const TextStyle(
              color: Colors.black,
            ),
          );
        }

        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}

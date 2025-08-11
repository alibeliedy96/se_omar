import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
 import 'package:shimmer/shimmer.dart';


class ShimmerHelper {
  static final Color _shimmerBase = Colors.grey.shade300;
  static const Color _shimmerHighlighted = Colors.white;

  buildBasicShimmer({double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: _shimmerBase,
      highlightColor: _shimmerHighlighted,
      child: Container(

        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color:Colors.grey
        ),
      ),
    );
  }

  buildCategoryShimmer({scontroller, itemCount = 10,double? height}) {
    return SizedBox(
      height:height?? 100,

      child: ListView.separated(
        itemCount: itemCount,
        controller: scontroller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: _shimmerBase,
              highlightColor: _shimmerHighlighted,
              child: Container(
                height: 56 ,
                width: 100 ,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x102c3e50),
                      offset: Offset(0, 0),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 5,
          );
        },
      ),
    );
  }

  buildProductShimmer({
    scontroller,
    itemCount = 15,
    double? height,
   bool isGrid=false,
    int gridCount=2
  }) {
    return isGrid?
    AlignedGridView.count(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: gridCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: 16,
      itemBuilder: (context, index) {

        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: height??100,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color:Colors.grey
            ),
          ),
        );
      },
    ): ListView.separated(
        padding:const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (c,i)=> Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: height??100,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color:Colors.grey
            ),
          ),
        ),
        separatorBuilder: (c,i)=>const SizedBox(height: 10,),
        itemCount: 7
    );
  }

  buildImagesLoadingShimmer({height,width,paddingHorizontal}) {
    return  SizedBox(
        height: height, width: width  ,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: paddingHorizontal??0),
          child: Shimmer.fromColors(
            baseColor: _shimmerBase,
            highlightColor: _shimmerHighlighted,
            child: Container(
              height: 55, width: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x102c3e50),
                    offset: Offset(0, 0),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

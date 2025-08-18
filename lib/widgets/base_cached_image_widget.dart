import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mr_omar/widgets/shimmer.dart';

import '../constants/localfiles.dart';


class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool? isShape;
  final bool? isBorder;
  final BorderRadiusGeometry? borderRadius;


  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.isShape = false,
    this.isBorder = false,

  });

  @override
  Widget build(BuildContext context) {
    if (borderRadius != null) return buildClipRRect(borderRadius!);
    return buildCachedNetworkImage();
  }

  ClipRRect buildClipRRect(BorderRadiusGeometry radius) {
    return ClipRRect(
      borderRadius: radius,
      child: buildCachedNetworkImage(),
    );
  }

  CachedNetworkImage buildCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      // httpHeaders: {
      //   HttpHeaders.authorizationHeader: 'Bearer ${CacheHelper.getData(key: AppConstants.token)}',
      // },
      placeholder: (_, __) => ShimmerHelper().buildImagesLoadingShimmer(width: double.infinity),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          border: isBorder == true ? Border.all(color: const Color(0xff9DFFDC), width: 0.6) : null,
          shape: isShape == true ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => noImage(width: width, height: height, fit: fit, isShape: isShape),
    );
  }

  static Widget noImage({double? width, double? height, BoxFit? fit, bool? isShape}) =>
      isShape == true
          ? ClipOval(
        child: Container(
          decoration: BoxDecoration(
            shape: isShape == true ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: Image.asset(Localfiles.holder, width: width, height: height, fit: BoxFit.cover),
        ),
      )
          : Container(
        decoration: BoxDecoration(
          shape: isShape == true ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Image.asset(Localfiles.holder, width: width ?? double.infinity, height: height, fit: BoxFit.cover),
      );
}

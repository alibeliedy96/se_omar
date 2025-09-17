import 'package:flutter/material.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/modules/explore/domain/models/units_response.dart';
import 'package:mr_omar/widgets/common_card.dart';

import '../../../../widgets/base_cached_image_widget.dart';

class UnitImagesList extends StatefulWidget {
  final List<Images>? images;
  const UnitImagesList({Key? key, this.images, }) : super(key: key);

  @override
  State<UnitImagesList> createState() => _UnitImagesListState();
}

class _UnitImagesListState extends State<UnitImagesList> {


  @override
  Widget build(BuildContext context) {
    if(widget.images?.isEmpty??true){
      return const SizedBox();
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: widget.images?.length??0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child:CachedImageWidget(imageUrl:widget.images?[index].imageUrl??"", fit: BoxFit.cover,),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

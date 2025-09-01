// import 'package:flutter/material.dart';
//
// import 'package:rxdart/rxdart.dart';
// import 'package:mr_omar/constants/text_styles.dart';
// import 'package:mr_omar/constants/themes.dart';
//
// class CommonSearchBar extends StatefulWidget {
//   final Function(String)? onChanged;
//   final TextEditingController? controller;
//   final String? hintText;
//   final bool enabled, isShow;
//   final double height;
//   final IconData? iconData;
//
//   const CommonSearchBar({
//     Key? key,
//     this.onChanged,
//     this.controller,
//     this.hintText,
//     this.enabled = true,
//     this.height = 48,
//     this.iconData,
//     this.isShow = true,
//   }) : super(key: key);
//
//   @override
//   State<CommonSearchBar> createState() => _CommonSearchBarState();
// }
//
// class _CommonSearchBarState extends State<CommonSearchBar> {
//   late final TextEditingController _controller =
//       widget.controller ?? TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final PublishSubject<String> _onChangeSubject = PublishSubject<String>();
//   final _debounceDuration = const Duration(milliseconds: 600);
//
//   @override
//   void initState() {
//     super.initState();
//     _onChangeSubject
//         .debounceTime(_debounceDuration)
//         .listen((txt) => widget.onChanged?.call(txt));
//
//     _controller.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     _onChangeSubject.close();
//     super.dispose();
//   }
//
//   void _onChanged(String value) {
//     _onChangeSubject.add(value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: SizedBox(
//         height: widget.height,
//         child: Row(
//           children: [
//             if (widget.isShow) ...[
//               Icon(
//                 widget.iconData ?? Icons.search,
//                 size: 20,
//                 color: Theme.of(context).primaryColor,
//               ),
//               const SizedBox(width: 8),
//             ],
//             Expanded(
//               child: TextField(
//                 controller: _controller,
//                 focusNode: _focusNode,
//                 enabled: widget.enabled,
//                 maxLines: 1,
//                 cursorColor: Theme.of(context).primaryColor,
//                 onChanged: _onChanged,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.zero,
//                   border: InputBorder.none,
//                   hintText: widget.hintText,
//                   hintStyle: TextStyles(context)
//                       .description()
//                       .copyWith(color: AppTheme.secondaryTextColor, fontSize: 16),
//                   suffixIcon: _controller.text.isNotEmpty
//                       ? IconButton(
//                     icon: const Icon(Icons.close, color: Colors.grey),
//                     onPressed: () {
//                       _controller.clear();
//                       _onChanged('');
//                     },
//                   )
//                       : null,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

import 'animation_line/animation_line.dart';
import 'animation_line/animation_line_controller.dart';




class SearchTextFieldWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final TextEditingController?  controller;
  final bool? isFilter;
  final String? hintText;
  final double? paddingHorizontal;
  const SearchTextFieldWidget({super.key, this.onChanged, this.controller, this.isFilter, this.paddingHorizontal, this.hintText});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> with SingleTickerProviderStateMixin {
  late  final TextEditingController _controller = widget.controller ?? TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final PublishSubject<String> _onChangeSubject = PublishSubject<String>();
  final _maxDurationToCallOnChange = const Duration(seconds: 2);
  late  final AnimationLineController _controllerTopLine= AnimationLineController(duration: _maxDurationToCallOnChange);

  @override
  void initState() {
    _searchFocusNode.addListener(_onSearchFocusChange);
    _controller.addListener(() {
      if(_controller.text.isEmpty){
        setState(() {

        });
      }
    });
    _onChangeSubject.debounceTime(_maxDurationToCallOnChange).listen((txt) {
      if (widget.onChanged != null) widget.onChanged!(txt);
    });
    super.initState();
  }
  void _onSearchFocusChange() {
    if (!_searchFocusNode.hasFocus) {
      // Perform search or update the value here
    }
  }
  @override
  void dispose() {
    _searchFocusNode.dispose();
    // _controller.dispose();
    _controllerTopLine.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                textAlignVertical: TextAlignVertical.center,
                onChanged: _callOnChange,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(

                  hintStyle: const TextStyle(fontSize: 13,  ),
                  filled: true,
                  hintText: widget.hintText,
                  // label: Text("search"),

                  // labelStyle:TextStyle(
                  //   color: AppColors.primary
                  // ) ,
                  suffixIcon:_controller.text.isNotEmpty? IconButton(
                    onPressed: () => _callOnChange(''),
                    icon:   const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                  ):null,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 30,
                      child: Row(
                        children: [
                          Icon(Icons.search,color: Theme.of(context).primaryColor,),
                          const SizedBox(width: 5,),
                          Container(width: 1,height: 20,color: Colors.grey.withOpacity(0.12),)
                        ],
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),


          ],
        ),
        if (_controllerTopLine.isActive) const SizedBox(height: 10),
        if (_controllerTopLine.isActive) AnimationLineLoading(controller: _controllerTopLine),

      ],
    );
  }

  void _callOnChange(String txt) {
    _controllerTopLine.upDate();
    if (txt.isEmpty) widget.controller?.clear();
    _onChangeSubject.add(txt);
    setState(() {});
  }



}

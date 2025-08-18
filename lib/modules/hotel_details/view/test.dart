//
//
//
//
//
//
//
//
// // File: unit_details_screen.dart
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:mr_omar/constants/localfiles.dart';
// import 'package:mr_omar/constants/text_styles.dart';
// import 'package:mr_omar/constants/themes.dart';
// import 'package:mr_omar/language/app_localizations.dart';
// import 'package:mr_omar/widgets/common_button.dart';
// import 'package:mr_omar/widgets/common_card.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import '../domain/models/unit_details_response.dart';
// import 'unit_details_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
//
// class UnitDetailsScreen extends StatefulWidget {
//   final String unitId;
//   const UnitDetailsScreen({Key? key, required this.unitId}) : super(key: key);
//
//   @override
//   State<UnitDetailsScreen> createState() => _UnitDetailsScreenState();
// }
//
// class _UnitDetailsScreenState extends State<UnitDetailsScreen> with TickerProviderStateMixin {
//   late final UnitDetailsController _controller;
//
//   // Animation controllers remain in the state
//   late final ScrollController _scrollController;
//   late final AnimationController _animationController;
//   double _imageHeight = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = UnitDetailsController();
//     _controller.addListener(_refresh);
//     _controller.init(widget.unitId);
//
//     // Animation logic stays here
//     _animationController = AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
//     _scrollController = ScrollController(initialScrollOffset: 0.0);
//     _scrollController.addListener(() {
//       if (mounted) {
//         // ... (your existing scroll listener logic)
//       }
//     });
//   }
//
//   void _refresh() {
//     if (mounted) setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _controller.removeListener(_refresh);
//     _controller.dispose();
//     _animationController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _imageHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: _controller.isLoading
//           ? Center(child: CircularProgressIndicator(),) // Show shimmer while loading
//           : _buildContent(),
//     );
//   }
//
//   Widget _buildContent() {
//     // final unit = _controller.unitDetails!;
//     return Stack(
//       children: [
//         CommonCard(
//           radius: 0,
//           color: AppTheme.scaffoldBackgroundColor,
//           child: ListView(
//             controller: _scrollController,
//             padding: EdgeInsets.only(top: 24 + _imageHeight),
//             children: [
//               // Hotel title and animation view
//               Padding(
//                 padding: const EdgeInsets.only(left: 24, right: 24),
//                 child: _getUnitDetails(unit),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0), child: Divider(height: 1)),
//               // Summary
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Text(Loc.alized.summary,
//                     style: TextStyles(context).bold().copyWith(
//                       fontSize: 14,
//                       letterSpacing: 0.5,
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                 child: Text(unit.description ?? '', textAlign: TextAlign.justify, style: TextStyles(context).getDescriptionStyle()),
//               ),
//               // Amenities, Reviews, etc. would go here
//               // ...
//               // Book Now Button
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: CommonButton(
//                   buttonText: Loc.alized.book_now,
//                   onTap: () => _controller.bookNow(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         _backgroundImageUI(unit),
//         _appBarUI(),
//       ],
//     );
//   }
//
//   Widget _backgroundImageUI(UnitDetailsData unit) {
//     final imageUrl = (unit.images != null && unit.images!.isNotEmpty) ? unit.images!.first.imagePath : null;
//     return Positioned(
//       top: 0, left: 0, right: 0,
//       child: AnimatedBuilder(
//         animation: _animationController,
//         builder: (BuildContext context, Widget? child) {
//           var opacity = 1.0 - (_animationController.value > 0.64 ? 1.0 : _animationController.value);
//           return SizedBox(
//             height: _imageHeight * (1.0 - _animationController.value),
//             child: imageUrl != null
//                 ? CachedNetworkImage(
//               imageUrl: imageUrl,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => Image.asset(Localfiles.hotel_1, fit: BoxFit.cover),
//             )
//                 : Image.asset(Localfiles.hotel_1, fit: BoxFit.cover),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _getUnitDetails(UnitDetailsData unit) {
//     return Row(
//       // ... UI to display unit.name, unit.address, etc.
//     );
//   }
//
//   Widget _appBarUI() {
//     // ... Your existing AppBar UI with back button
//   }
//
//
// }
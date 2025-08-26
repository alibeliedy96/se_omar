// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:intl/intl.dart';
// import 'package:mr_omar/main.dart';
//
// import '../view/choose_available_days_controller.dart';
//
// class ChooseDayWidget extends StatefulWidget {
//   final ChooseTimeController controller;
//   const ChooseDayWidget({super.key, required this.controller});
//
//   @override
//   State<ChooseDayWidget> createState() => _ChooseDayWidgetState();
// }
//
// class _ChooseDayWidgetState extends State<ChooseDayWidget> {
//   late final PageController _pageController;
//   late final Map<String, List<ShowAdvisorAppointmentsData>> _monthsMap;
//   late final List<String> _monthKeys;
//   int _currentPage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//
//
//     _monthsMap = {};
//     for (var appointment in widget.controller.appointmentDays) {
//       final date = DateTime.parse(appointment.date!);
//       final key = DateFormat('MMMM yyyy', langCode).format(date);
//       _monthsMap.putIfAbsent(key, () => []).add(appointment);
//     }
//     _monthKeys = _monthsMap.keys.toList();
//   }
//
//   void _goToPage(int page) {
//     if (page >= 0 && page < _monthKeys.length) {
//       _pageController.animateToPage(
//         page,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _currentPage = page;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//
//
//         /// --- Months Navigation (next/prev arrows) ---
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () => _goToPage(_currentPage - 1),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     _monthKeys[_currentPage],
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.arrow_forward_ios),
//                 onPressed: () => _goToPage(_currentPage + 1),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 12),
//
//         /// --- Days Grid ---
//         SizedBox(
//           height: 410,
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) => setState(() => _currentPage = index),
//             itemCount: _monthKeys.length,
//             itemBuilder: (context, pageIndex) {
//               final days = _monthsMap[_monthKeys[pageIndex]]!;
//               return AlignedGridView.count(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 crossAxisCount: 5,
//                 padding: const EdgeInsets.all(5),
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 itemCount: days.length,
//                 itemBuilder: (context, index) {
//                   final dayData = days[index];
//                   final date = DateTime.parse(dayData.date!);
//                   final isSelected =
//                       widget.controller.selectedDayIndex == index &&
//                           widget.controller.appointmentDays[index].date ==
//                               dayData.date;
//
//                   return _daysWidget(index, isSelected, context, date);
//                 },
//               );
//             },
//           ),
//         )
//       ],
//     );
//   }
//
//
//   Widget _daysWidget(int index, bool isSelected, BuildContext context, DateTime date) {
//     return InkWell(
//       onTap: () => widget.controller.selectDay(index),
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 DateFormat('EEEE', 'ar').format(date),
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black54,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 DateFormat.Md(langCode).format(date),
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black87,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

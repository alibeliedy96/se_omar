// import 'package:flutter/material.dart';
// import 'package:mr_omar/modules/unit_details/domain/models/unit_details_response.dart';
//
// import '../../../../constants/themes.dart';
// import '../../../../language/app_localizations.dart';
// import '../widgets/appointments_view.dart';
// import 'choose_available_days_controller.dart';
//
// class ChooseTimeScreen extends StatefulWidget {
//  final UnitDetailsData unit;
//   const ChooseTimeScreen({super.key, required this.unit,  });
//
//   @override
//   State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
// }
//
// class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
//   late final ChooseTimeController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = ChooseTimeController(monthlyPricing:widget.unit.monthlyPricing);
//     _controller.addListener(_refresh);
//
//
//     _controller.appointmentDays = ChooseTimeController.generateFakeAdvisorAppointments();
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
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar:  _getAppBarUi(Theme.of(context).disabledColor.withValues(alpha:0.4),
//           title: Loc.alized.booking,
//           Icons.arrow_back, AppTheme.backgroundColor, () {
//
//             Navigator.pop(context);
//
//           }),
//
//       body: _controller.appointmentDays.isEmpty
//           ? Text("لا يتوفر مواعيد متاحه الان")
//           : AppointmentsView(controller: _controller),
//     );
//   }
//   PreferredSizeWidget _getAppBarUi(
//       Color color, IconData icon, Color iconColor, VoidCallback onTap,
//       {required String title}) {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(AppBar().preferredSize.height),
//       child: SafeArea(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//
//             Center(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Colors.black,
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: AlignmentDirectional.centerStart,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
//                 child: Container(
//                   width: AppBar().preferredSize.height - 8,
//                   height: AppBar().preferredSize.height - 8,
//                   decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: const BorderRadius.all(Radius.circular(32.0)),
//                       onTap: onTap,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(icon, color: iconColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
// }
import 'package:flutter/material.dart';

import '../../../../constants/themes.dart';
import '../../../../language/app_localizations.dart';
import '../../../unit_details/domain/models/unit_details_response.dart';
import '../widgets/book_button.dart';
import '../widgets/booking_calender_widget.dart';
import 'choose_available_days_controller.dart';

class ChooseTimeScreen extends StatefulWidget {
  final UnitDetailsData unit;// Pass the unit ID to the screen
  const ChooseTimeScreen({super.key, required this.unit});

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  late final BookingCalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BookingCalendarController(unit: widget.unit);
    _controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar:  _getAppBarUi(Theme.of(context).disabledColor.withValues(alpha:0.4),
          title: Loc.alized.booking,
          Icons.arrow_back, AppTheme.backgroundColor, () {

            Navigator.pop(context);

          }),
      body: _controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(child: BookingCalendarWidget(controller: _controller)),
          // The checkout/booking button can go here
           BookButtonWidget(controller: _controller),
        ],
      ),
    );
  }
  PreferredSizeWidget _getAppBarUi(
      Color color, IconData icon, Color iconColor, VoidCallback onTap,
      {required String title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [

            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),

            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(icon, color: iconColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
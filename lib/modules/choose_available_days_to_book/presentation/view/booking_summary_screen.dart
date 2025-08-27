import 'package:flutter/material.dart';
import 'package:mr_omar/main.dart';

import '../../../../constants/themes.dart';
import '../../../../language/app_localizations.dart';
import '../../domain/models/bulk_pricing_response.dart';

import 'package:intl/intl.dart';

import '../widgets/cancellation_policy_widget.dart' hide CancellationPolicy;



class BookingSummaryScreen extends StatefulWidget {
  final BulkPricingResponse pricingData;
  const BookingSummaryScreen({super.key, required this.pricingData});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final summary = widget.pricingData.data?.summary;
    final dateRange = widget.pricingData.data?.dateRanges?.first;

    if (summary == null || dateRange == null) {
      return const Scaffold(body: Center(child: Text("لا توجد بيانات لعرضها")));
    }


    final fakePolicy = CancellationPolicy(
      name: "Flexible Cancellation",
      description:
      "You can cancel your booking up to 48 hours before check-in without any charge.",
      refundPercentage: "80",
    );
    return Scaffold(
      appBar:  _getAppBarUi(Theme.of(context).disabledColor.withValues(alpha:0.4),
          title: Loc.alized.booking_summary,
          Icons.arrow_back, AppTheme.backgroundColor, () {

            Navigator.pop(context);

          }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeaderCard(context, summary, dateRange),

            const SizedBox(height: 16),
            if ( dateRange.pricingBreakdown != null)
              _buildPricingDetailsCard(context, summary, dateRange),
            const SizedBox(height: 16),
            // if (summary.cancellationPolicy?.description != "null")
              _buildCancellationPolicyCard( context,  fakePolicy ),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButton(context,  ),
    );
  }

  // --- Helper Widgets for a Clean Build Method ---
  Widget _buildHeaderCard(BuildContext context, Summary summary, DateRanges dateRange) {
    final format = DateFormat('yyyy-MM-dd', langCode);
    final checkIn = format.format(DateTime.parse(dateRange.checkInDate!));
    final checkOut = format.format(DateTime.parse(dateRange.checkOutDate!));

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summary.unitName ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateInfo(Loc.alized.entry_date , checkIn),
                ),
                const SizedBox(width: 10, child: Icon(Icons.arrow_forward, color: Colors.grey)),
                Expanded(
                  child: _buildDateInfo(Loc.alized.exit_date , checkOut),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.nightlight_round, color: Colors.grey.shade600, size: 20),
                const SizedBox(width: 8),
                Text("${dateRange.pricingBreakdown?.breakdown?[0].nights} ${Loc.alized.nights}" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        const SizedBox(height: 4),
        Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildPricingDetailsCard(
      BuildContext context, Summary summary, DateRanges dateRange) {
    final breakdown = dateRange.pricingBreakdown!;
    final nights = dateRange.nights ?? 0;

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text( Loc.alized.price_details,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // عدد الليالي وسعر الليلة
            _buildPriceRow( Loc.alized.number_of_nights, nights.toString()),

            _buildPriceRow(
               Loc.alized.price_per_night,
              "${breakdown.breakdown?[0].dailyPrice??"0"} ${Loc.alized.egp}" ,
            ),


            const Divider(height: 24, thickness: 1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text( Loc.alized.total,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${breakdown.totalPrice} ${Loc.alized.egp}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String? value) {
    if (value == null  ) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
          Text(
            "$value",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationPolicyCard(
      BuildContext context, CancellationPolicy policy) {

    if ((policy.description == null || policy.description!.isEmpty) &&

        policy.refundPercentage == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.policy_outlined,
                    color: Colors.grey.shade600, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    policy.name ?? "Cancellation Policy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (policy.description != null && policy.description!.isNotEmpty)
              Text(
                policy.description!,
                style: TextStyle(color: Colors.grey.shade700, height: 1.5),
              ),

            if (policy.refundPercentage != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "${Loc.alized.refund}: ${policy.refundPercentage}%",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ElevatedButton(
          onPressed:   () {}  ,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text( Loc.alized.continue_and_pay  , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
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

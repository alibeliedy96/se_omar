import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mr_omar/modules/unit_details/logic/unit_details_cubit/unit_details_cubit.dart';

import '../../../../language/app_localizations.dart';
import '../../../../utils/uti.dart';
import '../../domain/request/create_review_request.dart';


/// Call this function to show the Add Review dialog.
/// onSubmit will be called with the CreateReviewRequestModel when user submits.
Future<void> showAddReviewDialog({
  required BuildContext context,
  required int unitId,

}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: _AddReviewDialogContent(unitId: unitId, ),
    ),
  );
}

class _AddReviewDialogContent extends StatefulWidget {
  final int unitId;


  const _AddReviewDialogContent({
    Key? key,
    required this.unitId,

  }) : super(key: key);

  @override
  State<_AddReviewDialogContent> createState() =>
      _AddReviewDialogContentState();
}

class _AddReviewDialogContentState extends State<_AddReviewDialogContent> {
  double overall = 0;
  double room = 0;
  double service = 0;
  double pricing = 0;
  double location = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _trySubmit() async {
    final comment = _commentController.text.trim();
    if (overall == 0) {

      UTI.showSnackBar(context, Loc.alized.please_provide_an_overall_rating, 'error');
      return;
    }
    if (comment.isEmpty) {

      UTI.showSnackBar(context, Loc.alized.please_add_a_short_comment, 'error');
      return;
    }

    setState(() => _submitting = true);

    // Simulate small delay for UX - remove if you will call real API here
    await Future.delayed(const Duration(milliseconds: 300));

    final model = CreateReviewRequestModel(
      unitId: widget.unitId,
      overallRating: overall,
      roomRating: room,
      serviceRating: service,
      pricingRating: pricing,
      locationRating: location,
      comment: comment,
    );

    UnitDetailsCubit.get().createReview(createReviewRequestModel: model,context: context);

    if (mounted) {
      setState(() => _submitting = false);
      Navigator.of(context).pop();
    }
  }

  void _showSnack(String msg) {
    final scaffold = ScaffoldMessenger.maybeOf(context);
    if (scaffold != null) {
      scaffold.showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  Color _surfaceColor(BuildContext c) =>
      Theme.of(c).dialogBackgroundColor; // supports dark/light

  Color _primaryColor(BuildContext c) => Theme.of(c).colorScheme.primary;

  Widget _ratingRow(String label, double value, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: RatingBar.builder(
                initialRating: value,
                minRating: 0,
                allowHalfRating: true,
                glow: false,
                itemSize: 22,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                unratedColor: Theme.of(context).disabledColor.withOpacity(0.2),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: _primaryColor(context),
                ),
                onRatingUpdate: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = _surfaceColor(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // header
            Row(
              children: [
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    Loc.alized.add_your_review,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // close button
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.close, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // overall big rating
            Column(
              children: [
                Text(
                  Loc.alized.overall_rating,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                RatingBar.builder(
                  initialRating: overall,
                  minRating: 0,
                  allowHalfRating: true,
                  glow: false,
                  itemCount: 5,
                  itemSize: 36,
                  unratedColor: Theme.of(context).disabledColor.withOpacity(0.2),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: _primaryColor(context),
                  ),
                  onRatingUpdate: (rating) => setState(() => overall = rating),
                ),
                const SizedBox(height: 6),
                Text(
                  overall > 0 ? overall.toStringAsFixed(1) : "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 14),

            // other detailed ratings
            _ratingRow( Loc.alized.room, room, (r) => setState(() => room = r)),
            _ratingRow(Loc.alized.service, service, (r) => setState(() => service = r)),
            _ratingRow(Loc.alized.price, pricing, (r) => setState(() => pricing = r)),
            _ratingRow(Loc.alized.location, location, (r) => setState(() => location = r)),

            const SizedBox(height: 10),

            // comment
            TextField(
              controller: _commentController,
              maxLines: 4,
              minLines: 2,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: Loc.alized.write_a_short_review,
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor ??
                    Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),

            const SizedBox(height: 14),

            // actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _submitting ? null : () => Navigator.of(context).pop(),
                    child: Text(Loc.alized.cancel,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _submitting ? null : _trySubmit,
                    child: _submitting
                        ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                        :   Text(
                       Loc.alized.submit_review,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
 Loc.alized.your_review_will_help_others_make_informed_decisions,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

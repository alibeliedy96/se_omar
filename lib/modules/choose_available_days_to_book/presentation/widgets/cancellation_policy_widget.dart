import 'package:flutter/material.dart';

// --- افترض أن هذا الموديل موجود لديك ---
class CancellationPolicy {
  String? description;
  CancellationPolicy({this.description});
}
// --- نهاية الافتراض ---


/// Helper for creating a single price line item (e.g., "Cleaning Fee" ..... "$50")
Widget _buildPriceRow(String label, int? value) {
  if (value == null || value == 0) return const SizedBox.shrink();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
        Text(
          "$value \$",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

/// Helper for creating the cancellation policy card.
Widget _buildCancellationPolicyCard(BuildContext context, CancellationPolicy policy) {
  // Return an empty widget if there's no description to show.
  if (policy.description == null || policy.description!.isEmpty) {
    return const SizedBox.shrink();
  }

  return Card(
    elevation: 0,
    color: Colors.grey.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.policy_outlined, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              policy.description!,
              style: TextStyle(color: Colors.grey.shade700, height: 1.5),
            ),
          ),
        ],
      ),
    ),
  );
}
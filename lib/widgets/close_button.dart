
import 'package:flutter/material.dart';


class ClosWidget extends StatelessWidget {
  const ClosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(Icons.close_outlined, color: Colors.grey, size: 18),
    );
  }
}

import 'package:flutter/material.dart';
import 'animation_line_controller.dart';

class AnimationLineLoading extends StatefulWidget {
  final AnimationLineController controller;

  const AnimationLineLoading({Key? key, required this.controller}) : super(key: key);

  @override
  State<AnimationLineLoading> createState() => _AnimationLineLoadingState();
}

class _AnimationLineLoadingState extends State<AnimationLineLoading> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 2,
      color: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      value: widget.controller.currentValue,
    );
  }
}

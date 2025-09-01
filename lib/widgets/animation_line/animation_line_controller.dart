import 'dart:async';

import 'package:flutter/material.dart';

class AnimationLineController extends ChangeNotifier {
  final Duration duration;

  AnimationLineController({required this.duration});

  // ----------- vars -----------
  Timer? _timer;

  final int _updateTimeInMilliseconds = 33;
  late final int _maxValue = duration.inMilliseconds;

  int _currentValueInMilliseconds = 0;

  // ----------- data -----------
  double get currentValue => _currentValueInMilliseconds / _maxValue;
  bool get isActive => _timer != null;

  // ----------- voids -----------
  void upDate() {
    print("call update");
    if (_timer != null) _timer!.cancel();
    if (_timer != null) _currentValueInMilliseconds = 0;
    if (_timer != null) print("ACTIVE");

    _timer = Timer.periodic(Duration(milliseconds: _updateTimeInMilliseconds), (t) {
      _currentValueInMilliseconds += _updateTimeInMilliseconds;
      if (_currentValueInMilliseconds >= _maxValue) {
        _currentValueInMilliseconds = 0;
        _timer!.cancel();
        _timer = null;
      }
      notifyListeners();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:mr_omar/constants/themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle title() {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 24,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle description() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: AppTheme.secondaryTextColor,
        );
  }

  TextStyle regular() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle bold() {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14,
          color: AppTheme.primaryTextColor,
        );
  }
}

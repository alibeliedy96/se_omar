import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';

class CommonTextFieldView extends StatelessWidget {
  final String? titleText;
  final String hintText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  final String? Function(String?)? validator;


  const CommonTextFieldView({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.titleText = '',
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAllowTopTitleView && titleText != '')
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Text(
                titleText ?? "",
                style: TextStyles(context).description(),
              ),
            ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadowColor: Colors.black12.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: 48,
                child: Center(

                  child: TextFormField(
                    controller: controller,
                    maxLines: 1,
                    onChanged: onChanged,
                    style: TextStyles(context).regular(),
                    obscureText: isObscureText,
                    cursorColor: Theme.of(context).primaryColor,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },

                    validator: validator,
                    decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                    keyboardType: keyboardType,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
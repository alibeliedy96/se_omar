import 'package:flutter/material.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';

class CommonTextFieldView extends StatefulWidget {
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
  State<CommonTextFieldView> createState() => _CommonTextFieldViewState();
}

class _CommonTextFieldViewState extends State<CommonTextFieldView> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isAllowTopTitleView && widget.titleText != '')
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
              child: Text(
                widget.titleText ?? "",
                style: TextStyles(context).description(),
              ),
            ),
          TextFormField(
            controller: widget.controller,
            maxLines: 1,

            onChanged: widget.onChanged,
            style: TextStyles(context).regular(),
            obscureText: _obscureText,
            cursorColor: Theme.of(context).primaryColor,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Theme.of(context).cardColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.6)),
              suffixIcon: widget.isObscureText
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : null,
            ),


            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}

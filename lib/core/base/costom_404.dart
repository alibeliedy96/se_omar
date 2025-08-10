import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/localfiles.dart';
import 'custom_button_with_border.dart';

class Custom404 extends StatefulWidget {
  final String? title;
  final String? text;
  final String? btnTxt;
  final bool? isBtn;
  final String? imagePath;
  final Function()? onTap;
  final double imageHeight;
  final double textFontSize;

  const Custom404({super.key,
    this.title,
    required this.text,
    required this.btnTxt,
    required this.onTap,
    this.imageHeight = 200.0,
    this.textFontSize = 16, this.imagePath, this.isBtn,
  });

  @override
  State<Custom404> createState() => _Custom404State();
}

class _Custom404State extends State<Custom404> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              widget.imagePath??Localfiles.image_404,
              height: widget.imageHeight,
              fit: BoxFit.scaleDown,
              matchTextDirection: true,
            ),
          ),
          Center(
            child: widget.title == null
                ? const SizedBox()
                : Text(
              widget.title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.textFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.text ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.textFontSize,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          if(widget.isBtn==true)
          CustomButton(
            onTap: () {
              widget.onTap!();
            },
            txt: widget.btnTxt??"",
            fillColor: Theme.of(context).primaryColor, textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

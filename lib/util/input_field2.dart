import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/dimensions.dart';

class InputField2 extends StatelessWidget {
  final String? title;
  final String subTitle;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? text;
  final bool obscureText;
  final double? marginRight;
  final double? marginBottom;
  final double? width;
  final double? radius;
  final double? height;
  final Color? color;
  final int? maxLine;
  final double? size;
  final double? heightPadding;
  final Color? bgColor;
  final Function? onChanged;
  final Color? borderColor;

  const InputField2({
    Key? key,
    this.title,
    required this.controller,
    this.suffixIcon,
    this.focusNode,
    this.nextFocus,
    this.keyboardType,
    this.obscureText = false,
    this.marginRight,
    this.marginBottom,
    this.width,
    this.radius,
    this.color,
    this.maxLine,
    this.prefixIcon,
    required this.subTitle,
    this.height,
    this.size,
    this.bgColor,
    this.text,
    this.onChanged,
    this.borderColor,
    this.heightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
              color: Get.theme.unselectedWidgetColor,
              fontSize: Dimensions.fontSizeDefault),
        ),
        SizedBox(
          height: heightPadding ?? Dimensions.radiusDefault,
        ),
        Container(
          margin: EdgeInsets.only(
              right: marginRight ?? 0, bottom: marginBottom ?? 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          width: width ?? Get.width,
          height: height ?? 50,
          decoration: BoxDecoration(
            color: bgColor ?? Get.theme.cardColor,
            borderRadius: BorderRadius.circular(radius ?? 12),
            border: Border.all(color: borderColor ?? Colors.transparent),
          ),
          child: TextFormField(
            onChanged:
                onChanged != null ? (String value) => onChanged!(value) : null,
            focusNode: focusNode,
            maxLines: maxLine,
            obscureText: obscureText,
            controller: controller,
            cursorHeight: 25,
            onFieldSubmitted: (_) {},
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: subTitle,
                suffix: text,
                hintStyle: TextStyle(
                  fontSize: size ?? 14,
                  color: color ?? Colors.black26,
                )),
          ),
        ),
      ],
    );
  }
}

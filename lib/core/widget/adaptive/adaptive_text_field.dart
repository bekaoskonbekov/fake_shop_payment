import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../themes/app_theme.dart';
import '../../themes/colors.dart';

class AdaptiveTextField extends StatelessWidget {
  String os;
  TextEditingController controller;
  TextInputAction? textInputAction;
  TextInputType type;
  String? label;
  String? hintText;
  bool isPassword;
  IconData? prefix;
  IconData? suffix;
  var suffixPressed;
  var onTap;
  InputBorder inputBorder;
  BoxDecoration? boxDecoration;
  int maxLine;
  int minLine;
  bool isExpanded = false;

  var onSubmit;
  var onChange;
  var validate;
  bool isClickable = true;

  AdaptiveTextField({
    Key? key,
    required this.os,
    this.label,
    this.hintText,
    required this.controller,
    this.onTap,
    this.type = TextInputType.text,
    this.isPassword = false,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.onChange,
    this.onSubmit,
    this.validate,
    this.textInputAction,
    this.inputBorder = const OutlineInputBorder(),
    this.boxDecoration,
    this.isClickable = true,
    this.maxLine = 1,
    this.minLine = 1,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (os == 'android') {
      return TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        expands: isExpanded,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        textInputAction: textInputAction,
        maxLines: isExpanded == true?null:maxLine,
        minLines: (isExpanded == true)?null:maxLine,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefix != null ? Icon(prefix) : null,
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: inputBorder,
          hintText: hintText,
        ),
      );
    }

    return CupertinoTextFormFieldRow(
      controller: controller,
      validator: validate,
      prefix: prefix != null
          ? Icon(
              prefix,
              color: defaultColor,
            )
          : null,
      /*  suffix:suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
          suffix,
        ),
      ): null,*/

      onTap: onTap,
      keyboardType: type,
      obscureText: isPassword,
      placeholder: label,
      onChanged: onChange,
      // onSubmitted: onSubmit,
      textInputAction: textInputAction,
      decoration: boxDecoration,
    );
  }
}

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../themes/app_theme.dart';
import '../../themes/colors.dart';

class AdaptiveButton extends StatelessWidget {
  String os;
  Color background = Colors.teal;
  double width = double.infinity;
  double height = 50;
  bool isUpperCase = true;
  double radius = 3.0;
  var function;
  String text;
  AdaptiveButton({
    Key? key,
    required this.os,
    this.background = defaultColor,
    this.width = double.infinity,
    this.height = 50,
    this.isUpperCase = true,
    this.radius = 3.0,
    required this.function,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (os == 'android') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: background,
          ),
          width: width,
          height: height,
          child: MaterialButton(
            onPressed: function,
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              // isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
        ),
        width: width,
        height: height,
        child: CupertinoButton.filled(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : 'ios $text',
            // isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

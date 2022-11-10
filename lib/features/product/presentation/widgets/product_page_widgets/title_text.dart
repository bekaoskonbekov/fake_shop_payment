import 'package:flutter/material.dart';

class TitleText  extends StatelessWidget {
 final String title;
  const TitleText ({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
    title,
    textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.w700,
),
);
  }
}

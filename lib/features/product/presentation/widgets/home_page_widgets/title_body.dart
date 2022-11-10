import 'package:flutter/material.dart';

class TitleBody extends StatelessWidget {
  const TitleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
      child: Text(
        "Find your style",
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TitlePopular extends StatelessWidget {
  const TitlePopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
      child: Row(
        children:  [
          const Expanded(
            child: Text(
              "Most Popular",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,),
            ),
          ),
          TextButton(onPressed:(){},
            child:  Text(
            "See all",
            style: TextStyle(
                fontSize: 17,
                color: Colors.orange[400],
                fontWeight: FontWeight.w700,),
          ),),
        ],
      ),
    );
  }
}

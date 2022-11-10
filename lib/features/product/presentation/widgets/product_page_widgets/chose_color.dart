import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../var.dart';


List<String> colorList = ["#2ab7ca", "#fed766", "#f4b6c2", "#005b96", "#e7d3d3","#fe8a71"];


class ChoseColor extends StatefulWidget {
  const ChoseColor({Key? key}) : super(key: key);
  @override
  State<ChoseColor> createState() => _ChoseColorState();
}

class _ChoseColorState extends State<ChoseColor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 17,),
            const Text(
              "Select color",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12,),
            colorWidget(),
          ],
        ),
      ),
    );
  }

  Widget colorWidget() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //ProductCubit.get(context).emit(ChangeCategory());
              setState(() {
                color = colorList[index];
                var temp = booleanColorList.map((c) => false).toList();
                booleanColorList.replaceRange(0, booleanColorList.length, temp);
                booleanColorList[index] = true;
              });
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: HexColor(colorList[index]).withOpacity(0.5),
                border: Border.all(
                  color: booleanColorList[index]
                      ?(Colors.orange[300])!
                      :Colors.white,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemCount: colorList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

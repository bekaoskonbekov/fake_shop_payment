import 'package:flutter/material.dart';

import '../../../../../core/var.dart';
import '../var.dart';


List<String> sizeList = ["S", "M", "L", "XL", "XXL"];


class ChoseSize extends StatefulWidget {
  const ChoseSize({Key? key}) : super(key: key);

  @override
  State<ChoseSize> createState() => _ChoseSizeState();
}

class _ChoseSizeState extends State<ChoseSize> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 17,
            ),
            const Text(
              "Select size",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            sizeWidget(),
          ],
        ),
      ),
    );
  }

  Widget sizeWidget() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //ProductCubit.get(context).emit(ChangeCategory());
              setState(() {
                size = sizeList[index];
                var temp = booleanSizeList.map((c) => false).toList();
                booleanSizeList.replaceRange(0, booleanSizeList.length, temp);
                booleanSizeList[index] = true;
              });
            },
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: booleanSizeList[index] == true
                    ? Colors.black87
                    : Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                  child: Text(
                sizeList[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: booleanSizeList[index] == true
                        ? Colors.white
                        : Colors.black87),
              )),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemCount: sizeList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

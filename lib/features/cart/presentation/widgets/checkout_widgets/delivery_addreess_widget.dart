import 'package:flutter/material.dart';

import '../../../../../core/font_icon/icon_broken.dart';
import '../../../../../core/localization/get_translate.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getTranslated(
            context, "DeliveryAddressWidget_page_text_delivery_key")),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(13)),
              ),
              child: const Icon(IconBroken.Location),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("20845 Dara Maraba"),
                Text(
                  "Syria",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../consts/conste.dart';
import 'our_button.dart';

Widget exitDialog() {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkColor).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to exit?".text.size(16).color(darkColor).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
              color: mainColor,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"),
          ourButton(
              color: mainColor,
              onPress: () {
                Get.back();
              },
              textColor: whiteColor,
              title: "No"),
        ],
      )
    ]).box.color(lightColor).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}

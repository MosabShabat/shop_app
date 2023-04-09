import 'package:get/get.dart';

import '../consts/conste.dart';

Widget singInWidget(
    {required BuildContext context, img, String? title, color, onTap}) {
  return Row(
    children: [
      Image.asset(img),
      (context.safePercentWidth * 20).widthBox,
      title!.tr.text
          .fontFamily(regular)
          .size(14)
          .color(whiteColor)
          .fontFamily(bold)
          .make(),
    ],
  )
      .box
      .rounded
      .height(60)
      .padding(const EdgeInsets.symmetric(horizontal: 20))
      .color(color)
      .width(context.screenWidth - 40)
      .make()
      .onTap(onTap);
}

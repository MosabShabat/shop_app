import 'package:get/get.dart';

import '../consts/conste.dart';

Widget smallContainer({Widget? widget, color}) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )),
    child: Center(
      child: widget,
    ),
  );
}

Widget fullContainer({Widget? widget, color,width,height}) {
  return Container(
    width: width,
    height: height,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: widget,
    ),
  );
}

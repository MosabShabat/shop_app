
import '../consts/conste.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(150, 150)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(mainColor),
  );
}

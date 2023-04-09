import 'package:get/get.dart';
import '../../consts/conste.dart';
import '../../controllers/auth_controller.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/singin_widget.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  var controller = Get.put(AuthController());

  //final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: appName.tr.text
                  .fontFamily(bold)
                  .size(20)
                  .color(mainColor)
                  .make()),
          (context.screenHeight * 0.07).heightBox,
          applogoWidget(),
          40.heightBox,
          discoverYouStyle.tr.text
              .fontFamily(bold)
              .size(24)
              .color(darkColor)
              .make(),
          40.heightBox,
          getQualityAndClassy.tr.text
              .fontFamily(regular)
              .size(13)
              .maxLines(2)
              .color(textGrayColor)
              .make(),
          60.heightBox,
          singInWidget(
              context: context,
              img: imgB7,
              color: redColor,
              title: signInWithGoogle,
              onTap: () {
                controller.signInWithGoogle();
              }),
          20.heightBox,
          singInWidget(
              context: context,
              img: imgB10,
              color: mainColor,
              title: signInWithFacebook,
              onTap: () {
                //  controller.signInWithFacebook();
              }),
          20.heightBox,
          singInWidget(
              context: context,
              img: imgB8,
              color: darkColor,
              title: signInWithApple,
              onTap: () {}),
          20.heightBox,
        ],
      ),
    );
  }
}

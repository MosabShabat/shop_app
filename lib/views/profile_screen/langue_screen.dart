import 'package:get/get.dart';
import 'package:shop_app/widget_common/applogo_widget.dart';

import '../../consts/conste.dart';
import '../../controllers/auth_controller.dart';
import '../../local/MyLocalController.dart';
import '../../widget_common/our_button.dart';

class langueScreen extends StatefulWidget {
  const langueScreen({super.key});

  @override
  State<langueScreen> createState() => _langueScreenState();
}

class _langueScreenState extends State<langueScreen> {
  MyLocalController MLC = Get.find();
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkColor,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title:
              Selectlanguage.tr.text.color(darkColor).fontFamily(bold).make(),
        ),
        body: Column(
          children: [
            40.heightBox,
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(Confirm.tr),
                    content: Text(changLan.tr),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(no.tr),
                      ),
                      TextButton(
                        onPressed: () async {
                          MLC.chageLang('en');
                          Get.back();
                        },
                        child: Text(yes.tr),
                      )
                    ],
                  ),
                );
              },
              leading: Image.asset(engFlag),
              title: English.tr.text.color(darkColor).fontFamily(bold).make(),
            )
                .box
                .rounded
                .height(60)
                .width(context.screenWidth - 40)
                .color(grayColor)
                .margin(const EdgeInsets.symmetric(horizontal: 40))
                .make(),
            20.heightBox,
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(Confirm.tr),
                    content: Text(changLan.tr),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(no.tr),
                      ),
                      TextButton(
                        onPressed: () async {
                          MLC.chageLang('ar');
                          Get.back();
                        },
                        child: Text(yes.tr),
                      )
                    ],
                  ),
                );
              },
              leading: Image.asset(
                psFlag,
                width: 35,
                height: 35,
              ),
              title: Arabic.tr.text.color(darkColor).fontFamily(bold).make(),
            )
                .box
                .rounded
                .height(60)
                .width(context.screenWidth - 40)
                .color(grayColor)
                .margin(const EdgeInsets.symmetric(horizontal: 40))
                .make(),
          ],
        ));
  }
}

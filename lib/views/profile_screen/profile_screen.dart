import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/views/auth_screen/singin_screen.dart';
import 'package:shop_app/views/profile_screen/edit_profile.dart';
import 'package:shop_app/widget_common/applogo_widget.dart';
import '../../consts/conste.dart';
import '../../controllers/auth_controller.dart';
import '../../local/MyLocalController.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/small_container.dart';
import '../../widget_common/theme_app.dart';
import 'langue_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    final AuthController _authController = Get.find();
    var controller = Get.put(() => FirestorServices());
    final controllerTheam = Get.find<SettingsController>();

    bool light = true;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Settings.tr.text.color(darkColor).fontFamily(bold).make(),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (_authController.isLoading.value) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (_authController.firebaseUser.value != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.heightBox,
                  Account.tr.text
                      .color(darkColor)
                      .fontFamily(bold)
                      .size(20)
                      .make(),
                  20.heightBox,
                  Obx(
                    () => ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image:
                                  NetworkImage(_authController.userImage ?? ''),
                            )),
                      ),
                      title: (_authController.userName ?? '')
                          .text
                          .color(darkColor)
                          .fontFamily(semibold)
                          .size(18)
                          .make(),
                      subtitle: (_authController.userEmail ?? '')
                          .text
                          .color(darkColor)
                          .fontFamily(regular)
                          .size(14)
                          .make(),
                      trailing: fullContainer(
                          width: 50.0,
                          height: 50.0,
                          widget: IconButton(
                            onPressed: () {
                              Get.to(() => EditProfileScreen());
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: darkColor,
                            ),
                          ),
                          color: grayColor),
                    ),
                  ),
                  20.heightBox,
                  Settings.tr.text
                      .size(20)
                      .color(darkColor)
                      .fontFamily(bold)
                      .make(),
                  20.heightBox,
                  ListTile(
                    leading: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.translate,
                          color: whiteColor,
                          size: 20,
                        ),
                        color: mainColor),
                    title: Language.tr.text
                        .color(darkColor)
                        .fontFamily(regular)
                        .size(18)
                        .make(),
                    trailing: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: IconButton(
                          onPressed: () {
                            Get.to(() => const langueScreen());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: darkColor,
                          ),
                        ),
                        color: grayColor),
                  ),
                  20.heightBox,
                  ListTile(
                    leading: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.location_on,
                          color: whiteColor,
                          size: 20,
                        ),
                        color: mainColor),
                    title: Editaddress.tr.text
                        .color(darkColor)
                        .fontFamily(regular)
                        .size(18)
                        .make(),
                    trailing: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.arrow_forward_ios,
                          color: darkColor,
                        ),
                        color: grayColor),
                  ),
                  20.heightBox,
                  ListTile(
                    leading: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.card_giftcard_outlined,
                          color: whiteColor,
                          size: 20,
                        ),
                        color: mainColor),
                    title: Editcreditcard.tr.text
                        .color(darkColor)
                        .fontFamily(regular)
                        .size(18)
                        .make(),
                    trailing: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.arrow_forward_ios,
                          color: darkColor,
                        ),
                        color: grayColor),
                  ),
                  20.heightBox,
                  ListTile(
                    leading: fullContainer(
                        width: 35.0,
                        height: 35.0,
                        widget: const Icon(
                          Icons.notifications,
                          color: whiteColor,
                          size: 20,
                        ),
                        color: mainColor),
                    title: notification.tr.text
                        .color(darkColor)
                        .fontFamily(regular)
                        .size(18)
                        .make(),
                    trailing: Switch(
                      value: light,
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      },
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.changeTheme(tealTheme);
                          GetStorage().write('theme', 'tealTheme');
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.teal,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.changeTheme(purpleTheme);
                          GetStorage().write('theme', 'purpleTheme');
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.purple,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.changeTheme(orangeTheme);
                          GetStorage().write('theme', 'orangeTheme');
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.question_mark_rounded,
                        color: mainColor,
                      ),
                      20.widthBox,
                      Feelfree.tr.text
                          .color(mainColor)
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                    ],
                  )
                      .box
                      .height(60)
                      .rounded
                      .color(Colors.blue.shade100)
                      .border(color: mainColor, width: 2)
                      .width(context.screenWidth - 20)
                      .make(),
                  20.heightBox,
                  Row(
                    children: [
                      20.widthBox,
                      const Icon(
                        Icons.logout_outlined,
                        color: whiteColor,
                      ),
                      100.widthBox,
                      Signout.tr.text
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                    ],
                  )
                      .box
                      .height(60)
                      .rounded
                      .color(redColor)
                      .width(context.screenWidth - 20)
                      .make()
                      .onTap(() async {
                    _authController.signOut();
                    Get.offAll(() => const SingInScreen());
                  }),
                  20.heightBox,
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Not signed in'),
            );
          }
        }),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../consts/conste.dart';
import '../../widget_common/applogo_widget.dart';
import '../auth_screen/singin_screen.dart';
import '../home_screen/home_screen.dart';

class SeplashScreen extends StatefulWidget {
  const SeplashScreen({super.key});

  @override
  State<SeplashScreen> createState() => _SeplashScreenState();
}

class _SeplashScreenState extends State<SeplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  return const SingInScreen();
                } else {
                  return const HomeScreen();
                  // Get.offAll(() => const HomeScreen());
                }
              }
              return Center(
                child: loadingIndicator(),
              );
            },
          ));
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

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
        ],
      ),
    );
  }
}

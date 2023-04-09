import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/consts/conste.dart';
import 'package:shop_app/services/firestor_services.dart';
import 'package:shop_app/widget_common/theme_app.dart';
import 'controllers/product_controller.dart';
import 'firebase_options.dart';
import 'local/MyLocalController.dart';
import 'local/local.dart';
import 'views/splash_screen/splash_screen.dart';

Future<void> main() async {
  Get.put(ApiController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  String selectedTheme = GetStorage().read('theme') ?? 'theme1';
  switch (selectedTheme) {
    case 'tealTheme':
      Get.changeTheme(tealTheme);
      break;
    case 'purpleTheme':
      Get.changeTheme(purpleTheme);
      break;
    case 'orangeTheme':
      Get.changeTheme(orangeTheme);
      break;
    default:
      Get.changeTheme(tealTheme);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controlle2 = Get.put(SettingsController());
    MyLocalController controller = Get.put(MyLocalController());
    final controller1 = Get.find<SettingsController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: controller1.themeData,
      locale: controller.initailLang,
      translations: MyLocal(),
      home: const SeplashScreen(),
    );
  }
}

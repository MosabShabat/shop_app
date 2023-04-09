import 'package:get/get.dart';
import '../../consts/conste.dart';
import '../../controllers/home_controller.dart';
import '../../widget_common/exit_dialog.dart';
import '../bag_screen/bag_screen.dart';
import '../favorite_screen/favorite_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeController());
  var navbarItem = [
    const BottomNavigationBarItem(
      label: '',
      icon: Icon(
        Icons.home_filled,
        color: whiteColor,
      ),
    ),
    const BottomNavigationBarItem(
      label: '',
      icon: Icon(
        Icons.shopping_bag,
        color: whiteColor,
      ),
    ),
    const BottomNavigationBarItem(
      label: '',
      icon: Icon(
        Icons.favorite_sharp,
        color: whiteColor,
      ),
    ),
    const BottomNavigationBarItem(
      label: '',
      icon: Icon(
        Icons.person,
        color: whiteColor,
      ),
    ),
  ];
  var navBody = [
    const HomePage(),
    const BagScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              // favorite
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: darkColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import '../../../consts/conste.dart';
import '../../../widget_common/our_button.dart';
import '../search_screen.dart';
import 'add_card.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color: mainColor,
            onPress: () {
              Get.to(() => const AddCardScreen());
            },
            textColor: whiteColor,
            title: "Go to payment"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            decoration: const BoxDecoration(color: redColor),
            child: Column(
              children: [
                20.heightBox,
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: darkColor,
                          size: 30,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                    ),
                    Address.tr.text
                        .size(20)
                        .color(darkColor)
                        .fontFamily(bold)
                        .make(),
                  ],
                )
              ],
            ),
          ),
          20.heightBox,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Search your City or street name',
              suffixIcon: IconButton(
                  onPressed: () {
                    Get.to(() => const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: darkColor,
                    size: 30,
                  )),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (value) {},
          )
              .box
              .padding(const EdgeInsets.symmetric(horizontal: 10))
              .margin(const EdgeInsets.symmetric(horizontal: 10))
              .rounded
              .width(context.screenWidth)
              .height(60)
              .color(grayColor)
              .make(),
        ],
      ),
    );
  }
}

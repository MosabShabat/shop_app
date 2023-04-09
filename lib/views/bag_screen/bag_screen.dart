import 'package:get/get.dart';
import '../../consts/conste.dart';
import '../../controllers/product_controller.dart';
import '../../model/product.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/our_button.dart';
import '../home_screen/item_details.dart';
import 'shipment_screen.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  var controller = Get.find<ApiController>();
  var serverController = Get.find<FirestorServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Products?>>(
        future: controller.getAllProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    width: context.screenWidth,
                    height: context.screenHeight,
                    color: lightColor,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: TextFormField(
                                      controller:
                                          serverController.searchController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: const Icon(Icons.search)
                                              .onTap(() {}),
                                          filled: true,
                                          fillColor: grayColor,
                                          hintText: Writehere.tr,
                                          hintStyle: const TextStyle(
                                              color: darkColor)),
                                    ),
                                  ),
                                  20.heightBox,
                                  Packagestatus.tr.text
                                      .fontFamily(bold)
                                      .size(20)
                                      .color(darkColor)
                                      .make(),
                                  20.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ourButton(
                                              color: mainColor,
                                              onPress: () async {
                                                Get.to(() =>
                                                    const ShipmentScreen());
                                              },
                                              textColor: whiteColor,
                                              title: "Packaging")
                                          .box
                                          .height(50)
                                          .rounded
                                          .make(),
                                      ourButton(
                                              color: grayColor,
                                              onPress: () async {},
                                              textColor: darkColor,
                                              title: "Sent")
                                          .box
                                          .height(50)
                                          .rounded
                                          .make(),
                                      ourButton(
                                              color: grayColor,
                                              onPress: () async {},
                                              textColor: darkColor,
                                              title: "Delivered")
                                          .box
                                          .height(50)
                                          .rounded
                                          .make(),
                                    ],
                                  )
                                ],
                              ),
                              20.heightBox,
                              ourButton(
                                      color: redColor,
                                      onPress: () async {},
                                      textColor: whiteColor,
                                      title: "Canceled")
                                  .box
                                  .height(50)
                                  .rounded
                                  .make(),
                              20.heightBox,
                              Youritems.tr.text
                                  .fontFamily(bold)
                                  .size(20)
                                  .color(darkColor)
                                  .make(),
                              20.heightBox,
                              VxSwiper.builder(
                                aspectRatio: 16 / 9,
                                autoPlay: true,
                                height: context.screenHeight - 100,
                                enlargeCenterPage: false,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  String? text = snapshot.data[index].title;
                                  List<String> words = text!.split(" ");
                                  String result = words.take(3).join(" ");
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: context.screenWidth,
                                            height: 400,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                      snapshot
                                                          .data[index].image,
                                                    )),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20))),
                                          ),
                                        ],
                                      ),
                                      20.heightBox,
                                      result.text
                                          .fontFamily(semibold)
                                          .size(14)
                                          .maxLines(1)
                                          .color(darkColor)
                                          .make(),
                                      5.heightBox,
                                      "\$ ${snapshot.data[index].price}"
                                          .text
                                          .fontFamily(regular)
                                          .size(14)
                                          .color(darkColor)
                                          .make(),
                                    ],
                                  ).onTap(() {
                                    Get.to(() => ItemDetails(
                                          id: "${snapshot.data[index].id}",
                                          title:
                                              "${snapshot.data[index].title}",
                                          image: snapshot.data[index].image,
                                          price: snapshot.data[index].price,
                                        ));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: "No Products".text.white.makeCentered(),
            );
          }
        },
      ),
    );
  }
}

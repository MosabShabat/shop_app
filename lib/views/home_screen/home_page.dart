import 'package:get/get.dart';

import '../../consts/conste.dart';
import '../../controllers/product_controller.dart';
import '../../model/product.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/small_container.dart';
import 'item_details.dart';
import 'search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.find<ApiController>();
  var serverController = Get.put(FirestorServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: pinkColor,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Center(
          child: Icon(Icons.shopping_cart_outlined),
        ),
      ),
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
                                              .onTap(() {
                                            if (serverController
                                                .searchController
                                                .text
                                                .isNotEmptyAndNotNull) {
                                              Get.to(() => SearchScreen(
                                                    title: serverController
                                                        .searchController.text,
                                                  ));
                                            }
                                          }),
                                          filled: true,
                                          fillColor: grayColor,
                                          hintText: Search.tr,
                                          hintStyle: const TextStyle(
                                              color: darkColor)),
                                    ),
                                  ),
                                  20.heightBox,
                                  Container(
                                    height: 125,
                                    width: context.screenWidth - 40,
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getDiscount.tr.text
                                              .fontFamily(bold)
                                              .size(20)
                                              .color(whiteColor)
                                              .make(),
                                          10.heightBox,
                                          getABig.tr.text
                                              .fontFamily(regular)
                                              .maxLines(2)
                                              .size(14)
                                              .color(lightColor)
                                              .make(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              20.heightBox,
                              categories.tr.text
                                  .fontFamily(bold)
                                  .size(18)
                                  .color(darkColor)
                                  .make(),
                              20.heightBox,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      snapshot.data!.length,
                                      (index) => Row(
                                            children: [
                                              smallContainer(
                                                color: grayColor,
                                                widget: Image.network(
                                                  snapshot.data[index].image,
                                                )
                                                    .box
                                                    .rounded
                                                    .clip(Clip.antiAlias)
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10))
                                                    .make(),
                                              ),
                                              20.widthBox
                                            ],
                                          )).toList(),
                                ),
                              ),
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

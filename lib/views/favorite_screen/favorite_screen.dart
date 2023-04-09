import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../consts/conste.dart';
import '../../consts/firebase_consts.dart';
import '../../controllers/product_controller.dart';
import '../../model/product.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/small_container.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var controller = Get.put(ApiController());
//  var serverController = Get.find<FirestorServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirestorServices.getWishlist(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            //  print(snapshot.data);
            return Center(
              child: "No Wishlist yet!".text.color(darkColor).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      20.heightBox,
                      TextFormField(
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: semibold,
                          color: darkColor,
                        ),
                        //   controller: nameController,
                        decoration: const InputDecoration(
                            labelText: '\t\tWrite here',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      )
                          .box
                          .width(context.screenWidth)
                          .height(50)
                          .rounded
                          .color(grayColor)
                          .make(),
                      20.heightBox,
                      FutureBuilder<List<Products?>>(
                        future: controller.getAllProduct(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                                          snapshot.data[index]
                                                              .image,
                                                        )
                                                            .box
                                                            .rounded
                                                            .clip(
                                                                Clip.antiAlias)
                                                            .margin(
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10))
                                                            .make(),
                                                      ),
                                                      20.widthBox
                                                    ],
                                                  )).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }).box.height(100).rounded.make();
                          } else {
                            return Center(
                              child: "No Products".text.white.makeCentered(),
                            );
                          }
                        },
                      ),
                      20.heightBox,
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 200,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    "${data[index]['image']}",
                                                  )),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                        ),
                                        20.heightBox,
                                        "${data[index]['title']}"
                                            .split(' ')
                                            .take(3)
                                            .join(' ')
                                            .text
                                            .fontFamily(semibold)
                                            .size(14)
                                            .make(),
                                        5.heightBox,
                                        "${data[index]['price']}"
                                            .tr
                                            .numCurrency
                                            .text
                                            .color(darkColor)
                                            .fontFamily(bold)
                                            .size(14)
                                            .make(),
                                      ],
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 20,
                                        child: Container(
                                          height: 48,
                                          width: 48,
                                          decoration: const BoxDecoration(
                                              color: grayColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  FirestorServices
                                                      .removeFromWishlist(
                                                          data[index].id);
                                                  VxToast.show(context,
                                                      msg:
                                                          "Removed from wishlist");
                                                  controller.isFav(false);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: mainColor,
                                                )),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

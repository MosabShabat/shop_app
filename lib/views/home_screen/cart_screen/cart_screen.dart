import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/consts/conste.dart';
import 'package:shop_app/consts/firebase_consts.dart';
import 'package:shop_app/views/home_screen/cart_screen/address_screen.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../services/firestor_services.dart';
import '../../../widget_common/applogo_widget.dart';
import '../../../widget_common/our_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var Cartcontroller = Get.put(CartController());

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: mainColor,
              onPress: () async {
                Get.to(() => const AddressScreen());
              },
              textColor: whiteColor,
              title: "Go to payment"),
        ),
        backgroundColor: whiteColor,
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
          title: Cart.tr.text.color(darkColor).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FirestorServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkColor).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              Cartcontroller.calculate(data);
              Cartcontroller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            //  scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "${data[index]['image']}",
                                          ))),
                                ).box.rounded.height(120).width(100).make(),
                                title: "${data[index]['title']}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(12)
                                    .make(),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${data[index]['price']}"
                                        .tr
                                        .numCurrency
                                        .text
                                        .color(darkColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    20.heightBox,
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      FirestorServices.deleteDocument(
                                          data[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: redColor,
                                    )),
                              )
                                  .box
                                  .rounded
                                  .width(context.screenWidth)
                                  .padding(const EdgeInsets.all(8))
                                  .margin(const EdgeInsets.all(8))
                                  .color(grayColor)
                                  .make();
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Total.tr.text
                              .fontFamily(bold)
                              .size(20)
                              .color(darkColor)
                              .make(),
                        ),
                        Obx(
                          () => "${Cartcontroller.totalP.value}"
                              .numCurrency
                              .text
                              .color(darkColor)
                              .size(16)
                              .fontFamily(bold)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .rounded
                        .width(context.screenWidth - 60)
                        .height(60)
                        .padding(const EdgeInsets.all(12))
                        .color(Colors.transparent)
                        .make(),
                    10.heightBox,
                  ],
                ),
              );
            }
          },
        ));
  }
}

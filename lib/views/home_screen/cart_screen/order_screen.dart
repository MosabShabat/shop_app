import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/consts/conste.dart';
import 'package:shop_app/views/home_screen/home_screen.dart';
import '../../../consts/firebase_consts.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../services/firestor_services.dart';
import '../../../widget_common/applogo_widget.dart';
import '../../../widget_common/our_button.dart';

class OrderScreen extends StatefulWidget {
  final String? number;
  const OrderScreen({super.key, required this.number});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var Cartcontroller = Get.put(CartController());

  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var controller = CartController.getCard(currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: grayColor,
              onPress: () async {
                await Cartcontroller.storUserInfo(
                    numberController.text, nameController.text);
                Get.to(() => const HomeScreen());
                VxToast.show(context, msg: 'The Operant succsessfully');
              },
              textColor: darkColor,
              title: "Buy now - ${Cartcontroller.totalP.value + 10} \$"),
        ),
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
          title: OrderReview.tr.text.color(darkColor).fontFamily(bold).make(),
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
              Cartcontroller.productSnapshot = data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Name.tr.text
                              .size(14)
                              .color(darkColor)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: semibold,
                              color: darkColor,
                            ),
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: 'Write here',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
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
                              .rounded
                              .width(context.screenWidth - 70)
                              .height(60)
                              .color(grayColor)
                              .make(),
                        ],
                      )
                          .box
                          .width(context.screenWidth)
                          .height(120)
                          .color(grayColor)
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      20.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Numberphone.tr.text
                              .size(18)
                              .color(darkColor)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: semibold,
                              color: darkColor,
                            ),
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Write here',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
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
                              .rounded
                              .width(context.screenWidth - 70)
                              .height(60)
                              .color(grayColor)
                              .make(),
                        ],
                      )
                          .box
                          .width(context.screenWidth)
                          .height(120)
                          .color(grayColor)
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      20.heightBox,
                      Item.tr.text
                          .color(darkColor)
                          .size(20)
                          .fontFamily(bold)
                          .make(),
                      20.heightBox,
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        "${data[index]['image']}",
                                      ))),
                            )
                                .box
                                .rounded
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 12))
                                .border(width: 1, color: darkColor)
                                .make();
                          }).box.height(160).width(context.screenWidth).make(),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Total.tr.text
                              .fontFamily(bold)
                              .size(20)
                              .color(darkColor)
                              .make(),
                          "${Cartcontroller.totalP.value}"
                              .numCurrency
                              .text
                              .color(darkColor)
                              .size(16)
                              .fontFamily(bold)
                              .make(),
                        ],
                      ),
                      20.heightBox,
                      Payment.tr.text
                          .color(darkColor)
                          .size(20)
                          .fontFamily(bold)
                          .make(),
                      20.heightBox,
                      ListTile(
                        leading: const Icon(
                          Icons.card_giftcard,
                          size: 25,
                          color: whiteColor,
                        )
                            .box
                            .width(context.screenWidth)
                            .height(60)
                            .width(60)
                            .color(Colors.white70)
                            .rounded
                            .padding(const EdgeInsets.all(12))
                            .make(),
                        title: CreditCard.tr.text.white
                            .size(16)
                            .fontFamily(bold)
                            .make(),
                        subtitle: StreamBuilder(
                          stream: CartController.getCard(currentUser!.uid),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: loadingIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Cart is empty"
                                    .text
                                    .color(darkColor)
                                    .make(),
                              );
                            } else {
                              var dataCard = snapshot.data!.docs;
                              Cartcontroller.productSnapshot = dataCard;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return "${dataCard[index]['number']}"
                                        .text
                                        .bold
                                        .size(16)
                                        .white
                                        .make();
                                  });
                            }
                          },
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: darkColor,
                        ).box.height(40).width(40).rounded.white.make(),
                      )
                          .box
                          .width(context.screenWidth)
                          .height(100)
                          .color(pinkColor)
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      20.heightBox,
                      const ListTile()
                          .box
                          .width(context.screenWidth)
                          .height(100)
                          .color(grayColor)
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      20.heightBox,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Total.tr.text
                                  .fontFamily(bold)
                                  .size(20)
                                  .white
                                  .make(),
                              "${Cartcontroller.totalP.value}"
                                  .numCurrency
                                  .text
                                  .white
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shipping.tr.text
                                  .fontFamily(bold)
                                  .size(20)
                                  .white
                                  .make(),
                              "10"
                                  .numCurrency
                                  .text
                                  .white
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ],
                      )
                          .box
                          .width(context.screenWidth)
                          .height(100)
                          .color(mainColor)
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      20.heightBox,
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}

import 'package:get/get.dart';
import 'package:shop_app/views/home_screen/cart_screen/cart_screen.dart';
import '../../consts/conste.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/small_container.dart';

class ItemDetails extends StatelessWidget {
  final String? image;
  final String? title;
  final double? price;
  final String? id;

  ItemDetails({super.key, this.title, this.image, this.price, this.id});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ApiController());
    var Cartcontroller = Get.put(CartController());
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
          title: Items.tr.text.color(darkColor).fontFamily(bold).make(),
        ),
        body: Column(
          children: [
            ListTile(
              title: title!.text
                  .color(darkColor)
                  .fontFamily(semibold)
                  .size(15)
                  .maxLines(1)
                  .make(),
              subtitle: "\$ $price"
                  .text
                  .color(darkColor)
                  .fontFamily(bold)
                  .size(16)
                  .make(),
              trailing: smallContainer(
                  color: pinkColor,
                  widget: Obx(
                    () => IconButton(
                        onPressed: () {
                          if (controller.isFav.value) {
                            FirestorServices.removeFromWishlist(id);
                            VxToast.show(context, msg: "Removed from wishlist");
                            controller.isFav(false);
                          } else {
                            controller.addToWishlist(
                                image, title, price, id, context);
                            controller.isFav(true);
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: controller.isFav.value ? mainColor : grayColor,
                        )),
                  )),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.screenWidth - 130,
                  height: 500,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "$image",
                          )),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
                20.widthBox,
                Column(
                  children: [
                    size.tr.text
                        .color(darkColor)
                        .fontFamily(semibold)
                        .size(20)
                        .make(),
                    20.heightBox,
                    smallContainer(
                      color: grayColor,
                      widget: "M"
                          .text
                          .color(darkColor)
                          .fontFamily(semibold)
                          .size(20)
                          .make()
                          .onTap(() {}),
                    ),
                    20.heightBox,
                    smallContainer(
                      color: grayColor,
                      widget: "S"
                          .text
                          .color(darkColor)
                          .fontFamily(semibold)
                          .size(20)
                          .make()
                          .onTap(() {}),
                    ),
                    20.heightBox,
                    smallContainer(
                      color: grayColor,
                      widget: "L"
                          .text
                          .color(darkColor)
                          .fontFamily(semibold)
                          .size(20)
                          .make()
                          .onTap(() {}),
                    ),
                    20.heightBox,
                    smallContainer(
                      color: grayColor,
                      widget: "XL"
                          .text
                          .color(darkColor)
                          .fontFamily(semibold)
                          .size(20)
                          .make()
                          .onTap(() {}),
                    ),
                    20.heightBox,
                    smallContainer(
                      color: pinkColor,
                      widget: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.message_rounded,
                            color: whiteColor,
                          )),
                    ),
                    20.heightBox,
                    smallContainer(
                      color: mainColor,
                      widget: IconButton(
                          onPressed: () async {
                            await ApiController.storUserProducts(
                                "$image", "$title", price!, "$id", context);
                            VxToast.show(context, msg: 'uploade succsessfully');

                            Get.to(() => CartScreen());
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: whiteColor,
                          )),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

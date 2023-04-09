import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../consts/conste.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/applogo_widget.dart';
import 'item_details.dart';

class SearchScreen extends StatefulWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // var controller = Get.find<ApiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder(
        future: FirestorServices.searchProducts(widget.title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found".text.color(darkColor).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where(
                  (element) => element['title']
                      .toString()
                      .toLowerCase()
                      .contains(widget.title!.toLowerCase()),
                )
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 320,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 8,
                ),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['image'],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            10.heightBox,
                            "${filtered[index]['title']}"
                                .split(' ')
                                .take(3)
                                .join(' ')
                                .text
                                .size(16)
                                .fontFamily(semibold)
                                .color(darkColor)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['price']}"
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                            .shadowMd
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                              id: "${filtered[index]['id']}",
                              title: "${filtered[index]['title']}",
                              image: filtered[index]['image'],
                              price: filtered[index]['price']));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

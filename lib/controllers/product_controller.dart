import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../consts/conste.dart';
import '../consts/firebase_consts.dart';
import '../model/product.dart';

class ApiController {
  final String BASE_URL = "https://fakestoreapi.com/";

  var isFav = false.obs;

  var quantity = 0.obs;
  var totalPrice = 0.obs;

  Future<List<Products>> getAllProduct() async {
    List<Products> l = [];
    Uri URI = Uri.parse("${BASE_URL}products");
    http.Response response = await http.get(URI);
    if (response.statusCode == 200) {
      var array = jsonDecode(response.body);
      array.forEach((e) => l.add(Products.fromJson(e)));
      return l;
    }
    return [];
  }

  Future<Products?> getOneProducts(id) async {
    Products l;
    Uri URI = Uri.parse("${BASE_URL}products/$id");
    http.Response response = await http.get(URI);
    if (response.statusCode == 200) {
      var object = jsonDecode(response.body);
      l = Products.fromJson(object);
      return l;
    }
    return null;
  }

  static storUserProducts(
      String image, String title, double price, String id, context) async {
    await FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myProductCollection)
        .add({
      'image': image,
      'title': title,
      'price': price,
      'id': id,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  addToWishlist(image, title, price, id, context) async {
    await FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myWhishCollection)
        .add({
      'image': image,
      'title': title,
      'price': price,
      'id': id,
      'added_by': currentUser!.uid
    });
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  calculateTotalPrice(price) {
    totalPrice.value = price = quantity.value;
  }
}

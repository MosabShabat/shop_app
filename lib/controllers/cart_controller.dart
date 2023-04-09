import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_app/consts/firebase_consts.dart';

import '../consts/conste.dart';

class CartController extends GetxController {
  String userUid = '';
  var totalP = 0.0.obs;
  late dynamic productSnapshot;

  storUserCard(String number, String expiry, String cvv, String name) async {
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(cardsCollection)
        .add({
      'name': name,
      'number': number,
      'cvv': cvv,
      'expiry': expiry,
      'added_by': currentUser!.uid
    });
    return true;
  }

  storUserInfo(String number, String name) async {
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(userInfoCollection)
        .add({
      'name': name,
      'number': number,
    });
    return true;
  }


  static getCard(uid) {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(cardsCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + double.parse(data[i]['price'].toString());
    }
  }
}

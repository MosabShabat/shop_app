import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../consts/conste.dart';
import '../consts/firebase_consts.dart';

class FirestorServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
  //       (User user) => user.uid,
  //     );

  static getProducts(uid) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myProductCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static getWishlist(uid) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myWhishCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }



  var searchController = TextEditingController();

  static searchProducts(title) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myProductCollection)
        .get();
  }

  static deleteDocument(docId) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myProductCollection)
        .doc(docId)
        .delete();
  }

  static removeFromWishlist(docId) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(myWhishCollection)
        .doc(docId)
        .delete();
  }

  Future<String> getCurrentID() async {
    return (_firebaseAuth.currentUser)!.uid;
  }

  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  getProfileImage() {
    if (_firebaseAuth.currentUser!.photoURL != null) {
      return Image.network(
        "${_firebaseAuth.currentUser!.photoURL}",
        height: 100,
        width: 100,
      );
    } else {
      return const Icon(
        Icons.account_circle,
        size: 100,
      );
    }
  }
}

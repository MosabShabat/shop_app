import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/firebase_consts.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkCurrentUser();
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        _checkCurrentUser();

        
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      firebaseUser.value = null;
    } catch (error) {
      print('Error signing out: $error');
    } finally {
      isLoading.value = false;
    }
  }

  storeUserData({cardName, cardNumber, expiryDate, cvv}) {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'card_name': cardName,
      'card_number': cardNumber,
      'expiry_date': expiryDate,
      'id': currentUser!.uid,
      'cvv': cvv,
    });
  }

  void _checkCurrentUser() async {
    isLoading.value = true;
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        firebaseUser.value = user;
      }
    } catch (error) {
      print('Error checking current user: $error');
    } finally {
      isLoading.value = false;
    }
  }

  String? get userName {
    return firebaseUser.value?.displayName;
  }

  String? get userEmail {
    return firebaseUser.value?.email;
  }

  String? get userImage {
    return firebaseUser.value?.photoURL;
  }
}

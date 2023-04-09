import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const usersCollection = "users";
const cardsCollection = "cards";
const productsCollection = "products";
const myProductCollection = "my_product";
const userInfoCollection = "user_info";
const myWhishCollection = "p_wishlist";


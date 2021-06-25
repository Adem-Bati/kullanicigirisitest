import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/firebase.dart';
import 'package:kullanicigirisitest/screens/SepetlerSayfasi/sepetler.dart';

class CartService {
  FlutterFireAuthService _authServices = FlutterFireAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Ürün ekleme fonksiyonu
  Future<void> addCart(
    String pname,
    String price,
    String image,
    String piece,
  ) async {
    var ref = _firestore
        .collection("Users")
        .doc(await _authServices.getCurrentUID())
        .collection("Cart");

    var documentRef = await ref.add({
      "pname": pname,
      "image": image,
      "price": price,
      "piece": piece,
    });

    return Cart(
        id: documentRef.id,
        image: image,
        pname: pname,
        price: price,
        piece: piece);
  }

  //status göstermek için
  Stream<QuerySnapshot> getCarts() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    //var result = _firestore.collection("Cart").snapshots();

    var result = _firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection('Cart')
        .orderBy("pname", descending: true)
        .snapshots();
    return result;
  }

  //status silmek için
  Future<void> removeCart(String docId) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Cart")
        .doc(docId)
        .delete();

    return ref;
  }

  Future<void> deleteCart() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection("Cart")
        //.where("baslik")
        .get()
        .then((QuerySnapshot ds) {
      ds.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }
}

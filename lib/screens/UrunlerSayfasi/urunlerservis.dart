import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/UrunlerSayfasi/urunler.dart';

class ProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = '';

  //Ürün ekleme fonksiyonu
  Future<void> addCategory(
      String category,
      String description,
      PickedFile pickedFile,
      String pid,
      String pname,
      String price,
      String type) async {
    var ref = _firestore.collection("Product");

    if (pickedFile == null) {
      mediaUrl = '';
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }

    var documentRef = await ref.add({
      "category": category,
      "description": description,
      "image": mediaUrl,
      "pid": pid,
      "pname": pname,
      "price": price,
      "type": type,
    });

    return Products(
        id: documentRef.id,
        category: category,
        description: description,
        image: mediaUrl,
        pid: pid,
        pname: pname,
        price: price,
        type: type);
  }

  //status göstermek için
  Stream<QuerySnapshot> getProducts(String title) {
    var ref = _firestore
        .collection("Product")
        .where("category", isEqualTo: title)
        .snapshots();

    return ref;
  }

  Stream<QuerySnapshot> getProductsSearch(String title) {
    var ref = _firestore
        .collection("Product")
        .where("type", isEqualTo: title)
        .snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeProduct(String docId) {
    var ref = _firestore.collection("Product").doc(docId).delete();
    return ref;
  }
}

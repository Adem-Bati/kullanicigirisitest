import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/KategorilerSayfasi/kategoriler.dart';

class CategoriesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();

  String mediaUrl = '';

  //kategori ekleme fonksiyonu
  Future<void> addCategory(
      String title, String tag, PickedFile pickedFile) async {
    var ref = _firestore.collection("Categories");

    if (pickedFile == null) {
      mediaUrl = '';
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }

    var documentRef = await ref.add({
      "title": title,
      "tag": tag,
      "image": mediaUrl,
    });

    return Categories(
        id: documentRef.id, title: title, tag: tag, image: mediaUrl);
  }

  //status göstermek için
  Stream<QuerySnapshot> getCategories() {
    var ref = _firestore.collection("Categories").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeCategories(String docId) {
    var ref = _firestore.collection("Categories").doc(docId).delete();

    return ref;
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/KampanyalarSayfasi/kampanyalar.dart';

class KampanyaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();

  String mediaUrl = '';

  //kategori ekleme fonksiyonu
  Future<void> addKampanya(
      String pname, String description, PickedFile pickedFile) async {
    var ref = _firestore.collection("Kampanya");

    if (pickedFile == null) {
      mediaUrl = '';
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }

    var documentRef = await ref.add({
      "pname": pname,
      "description": description,
      "image": mediaUrl,
    });

    return Kampanya(
        id: documentRef.id,
        pname: pname,
        description: description,
        image: mediaUrl);
  }

  //status göstermek için
  Stream<QuerySnapshot> getKampanya() {
    var ref = _firestore.collection("Kampanya").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeKampanya(String docId) {
    var ref = _firestore.collection("Kampanya").doc(docId).delete();

    return ref;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/firebase.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/SiparislerSayfasi/siparisler.dart';

class SiparisService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  FlutterFireAuthService _authServices = FlutterFireAuthService();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //kategori ekleme fonksiyonu
  Future<void> addSiparis(
      String adres, String kart, String ucret, String durum) async {
    var ref = _firestore
        .collection("Users")
        .doc(await _authServices.getCurrentUID())
        .collection("Siparis");

    var documentRef = await ref.add({
      "adres": adres,
      "kart": kart,
      "ucret": ucret,
      "durum": durum,
    });

    return Siparis(
        id: documentRef.id,
        adres: adres,
        kart: kart,
        ucret: ucret,
        durum: durum);
  }

  //status göstermek için
  Stream<QuerySnapshot> getSiparis() {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Siparis")
        .snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeSiparis(String docId) {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Siparis")
        .doc(docId)
        .delete();

    return ref;
  }
}

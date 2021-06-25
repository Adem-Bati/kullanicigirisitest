import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/firebase.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adresler.dart';

class AdresService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  FlutterFireAuthService _authServices = FlutterFireAuthService();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //kategori ekleme fonksiyonu
  Future<void> addAdres(
      String baslik, String sehirilce, String mahalle, String aciklama) async {
    var ref = _firestore
        .collection("Users")
        .doc(await _authServices.getCurrentUID())
        .collection("Adres");

    var documentRef = await ref.add({
      "baslik": baslik,
      "sehirilce": sehirilce,
      "mahalle": mahalle,
      "aciklama": aciklama,
    });

    return Adres(
        id: documentRef.id,
        baslik: baslik,
        sehirilce: sehirilce,
        mahalle: mahalle,
        aciklama: aciklama);
  }

  //status göstermek için
  Stream<QuerySnapshot> getAdres() {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Adres")
        .snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeAdres(String docId) {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Adres")
        .doc(docId)
        .delete();

    return ref;
  }
}

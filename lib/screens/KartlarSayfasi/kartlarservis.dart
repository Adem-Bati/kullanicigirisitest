import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/firebase.dart';
import 'package:kullanicigirisitest/firebase/firebasestorage.dart';
import 'package:kullanicigirisitest/screens/KartlarSayfasi/kartlar.dart';

class KartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FlutterFireAuthService _authServices = FlutterFireAuthService();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //kart ekleme fonksiyonu
  Future<void> addKart(
      String kullaniciadi, String kartnumara, String tarih, String cvv) async {
    var ref = _firestore
        .collection("Users")
        .doc(await _authServices.getCurrentUID())
        .collection("Kart");

    var documentRef = await ref.add({
      "kullaniciadi": kullaniciadi,
      "kartnumara": kartnumara,
      "tarih": tarih,
      "cvv": cvv,
    });

    return Kart(
        id: documentRef.id,
        kullaniciadi: kullaniciadi,
        kartnumara: kartnumara,
        tarih: tarih,
        cvv: cvv);
  }

  //status göstermek için
  Stream<QuerySnapshot> getKart() {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Kart")
        .snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeKart(String docId) {
    var ref = _firestore
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection("Kart")
        .doc(docId)
        .delete();

    return ref;
  }
}

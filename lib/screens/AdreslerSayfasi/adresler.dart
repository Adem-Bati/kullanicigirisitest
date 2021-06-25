import 'package:cloud_firestore/cloud_firestore.dart';

class Adres {
  String id;
  String baslik;
  String sehirilce;
  String mahalle;
  String aciklama;

  Adres({this.id, this.baslik, this.sehirilce, this.mahalle, this.aciklama});

  factory Adres.fromSnapshot(DocumentSnapshot snapshot) {
    return Adres(
      id: snapshot.id,
      baslik: snapshot["baslik"],
      sehirilce: snapshot["sehirilce"],
      mahalle: snapshot["mahalle"],
      aciklama: snapshot["aciklama"],
    );
  }
}

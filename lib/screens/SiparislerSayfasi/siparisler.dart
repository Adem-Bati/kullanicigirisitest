import 'package:cloud_firestore/cloud_firestore.dart';

class Siparis {
  String id;
  String adres;
  String kart;
  String ucret;
  String durum;

  Siparis({this.id, this.adres, this.kart, this.ucret, this.durum});

  factory Siparis.fromSnapshot(DocumentSnapshot snapshot) {
    return Siparis(
      id: snapshot.id,
      adres: snapshot["adres"],
      kart: snapshot["kart"],
      ucret: snapshot["ucret"],
      durum: snapshot["durum"],
    );
  }
}

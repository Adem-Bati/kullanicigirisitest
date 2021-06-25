import 'package:cloud_firestore/cloud_firestore.dart';

class Kart {
  String id;
  String baslik;
  String kullaniciadi;
  String kartnumara;
  String tarih;
  String cvv;

  Kart(
      {this.id,
      this.baslik,
      this.kullaniciadi,
      this.kartnumara,
      this.tarih,
      this.cvv});

  factory Kart.fromSnapshot(DocumentSnapshot snapshot) {
    return Kart(
      id: snapshot.id,
      baslik: snapshot["baslik"],
      kullaniciadi: snapshot["kullaniciadi"],
      kartnumara: snapshot["kartnumara"],
      tarih: snapshot["tarhih"],
      cvv: snapshot["cvv"],
    );
  }
}

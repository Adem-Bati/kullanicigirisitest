import 'package:cloud_firestore/cloud_firestore.dart';

class Kampanya {
  String id;
  String pname;
  String description;
  String image;

  Kampanya({this.id, this.pname, this.description, this.image});

  factory Kampanya.fromSnapshot(DocumentSnapshot snapshot) {
    return Kampanya(
      id: snapshot.id,
      pname: snapshot["pname"],
      description: snapshot["description"],
      image: snapshot["image"],
    );
  }
}

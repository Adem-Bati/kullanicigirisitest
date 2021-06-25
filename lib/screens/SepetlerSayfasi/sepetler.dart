import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String id;
  String pname;
  String price;
  String piece;
  String image;

  Cart({this.id, this.pname, this.price, this.image, this.piece});

  factory Cart.fromSnapshot(DocumentSnapshot snapshot) {
    return Cart(
      id: snapshot.id,
      pname: snapshot["pname"],
      price: snapshot["price"],
      piece: snapshot["piece"],
      image: snapshot["image"],
    );
  }
}

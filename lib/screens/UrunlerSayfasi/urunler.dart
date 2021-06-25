import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String id;
  String category;
  String description;
  String image;
  String pid;
  String pname;
  String price;
  String type;

  Products({
    this.id,
    this.category,
    this.description,
    this.image,
    this.pid,
    this.pname,
    this.price,
    this.type,
  });

  factory Products.fromSnapshot(DocumentSnapshot snapshot) {
    return Products(
      id: snapshot.id,
      category: snapshot["category"],
      description: snapshot["description"],
      image: snapshot["image"],
      pid: snapshot["pid"],
      pname: snapshot["pname"],
      price: snapshot["price"],
      type: snapshot["type"],
    );
  }
}

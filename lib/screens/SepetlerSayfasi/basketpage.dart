import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/SepetlerSayfasi/sepetlerservis.dart';
import 'package:kullanicigirisitest/screens/odemepage.dart';

class denemeBasket2 extends StatefulWidget {
  const denemeBasket2({Key key}) : super(key: key);

  @override
  _denemeBasket2State createState() => _denemeBasket2State();
}

class _denemeBasket2State extends State<denemeBasket2> {
  final _firestore = FirebaseFirestore.instance;
  CartService _service = CartService();
  double totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceGetir();
  }

  void priceGetir() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection("Cart")
        .get()
        .then((QuerySnapshot ds) {
      var map = ds.docs.asMap();
      totalPrice = 0;
      for (var i = 0; i < map.length; i++) {
        setState(() {
          totalPrice = totalPrice +
              int.parse(map[i]['price']) * int.parse(map[i]['piece']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      priceGetir();
    });
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Toplam:\n",
                        children: [
                          TextSpan(
                            text: totalPrice.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 190,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => odemePage(
                                          totalPrice: totalPrice.toString(),
                                        )));
                            //_service.getCartss();
                          },
                          color: Colors.brown[300],
                          child: Text(
                            "Alışverişi Tamamla",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: new Text("Sepetim",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  expandedHeight: 140,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/slider12.jpg"),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.0),
                              Colors.black.withOpacity(.6),
                            ])),
                      ),
                    ),
                  ),
                ),
              ];
            },
            //body: Center(),
            body: StreamBuilder(
                stream: _service.getCarts(),
                builder: (context, snaphot) {
                  return !snaphot.hasData
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.brown[300]),
                        ))
                      : ListView.builder(
                          itemCount: snaphot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost =
                                snaphot.data.documents[index];
                            Future<void> _showAlertDialog(BuildContext) {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Ürün sepetten çıkarılsın mı?"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    content: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                _service.removeCart(mypost.id);
                                                priceGetir();
                                              },
                                              child: Text("Evet")),
                                          InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Text("Hayır")),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            return GestureDetector(
                              onDoubleTap: () {
                                _showAlertDialog(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 88,
                                        child: AspectRatio(
                                          aspectRatio: 0.88,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: mypost["image"] == ""
                                                ? Image.asset(
                                                    "images/default.png")
                                                : Image.network(
                                                    mypost["image"]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mypost["pname"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 10),
                                          Text.rich(TextSpan(
                                              text: (double.parse(
                                                          mypost["price"]) *
                                                      double.parse(
                                                          mypost["piece"]))
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                              children: [
                                                TextSpan(
                                                  text: " x " +
                                                      mypost["piece"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ]))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                })));
  }
}

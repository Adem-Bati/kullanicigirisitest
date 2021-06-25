import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kullanicigirisitest/screens/SepetlerSayfasi/sepetlerservis.dart';

class denemeProductDetails extends StatefulWidget {
  final String category;
  final String description;
  final String image;
  final String pid;
  final String pname;
  final String price;
  final String type;
  final PickedFile profileImage;

  const denemeProductDetails({
    Key key,
    this.category,
    this.description,
    this.image,
    this.pid,
    this.pname,
    this.price,
    this.type,
    this.profileImage,
  }) : super(key: key);

  @override
  _denemeProductDetailsState createState() => _denemeProductDetailsState();
}

class _denemeProductDetailsState extends State<denemeProductDetails> {
  CartService _service = CartService();
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _descramentCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double fiyat = double.parse(widget.price) * _counter;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: BackButton(color: Colors.white),
                  automaticallyImplyLeading: false,
                  title: new Text(widget.pname,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.image == ""
                                  ? AssetImage("images/default.png")
                                  : NetworkImage(widget.image),
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          fiyat.toString() + " ₺",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        Text(
                          '$_counter ' + "Adet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(32.0),
                              color: Colors.brown[300],
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: _incrementCounter,
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            )),
                        Container(
                            height: 50,
                            width: 50,
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(32.0),
                              color: Colors.brown[300],
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {
                                  if (_counter != 1) {
                                    _descramentCounter();
                                  }
                                },
                                child: Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.only(right: 50, left: 50),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.brown[300],
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              _service
                                  .addCart(
                                widget.pname,
                                widget.price,
                                widget.image,
                                _counter.toString(),
                              )
                                  .then((value) {
                                Fluttertoast.showToast(
                                    msg: "Durum eklendi!",
                                    timeInSecForIosWeb: 2,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.grey[600],
                                    textColor: Colors.white,
                                    fontSize: 14);
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Sepete Ekle",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            )));
  }
}

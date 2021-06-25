import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/firebase.dart';

class BilgilerimPage extends StatefulWidget {
  const BilgilerimPage({Key key}) : super(key: key);

  @override
  _BilgilerimPageState createState() => _BilgilerimPageState();
}

class _BilgilerimPageState extends State<BilgilerimPage> {
  final _firestore = FirebaseFirestore.instance;

  var map;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserDescription();
  }

  void getCurrentUserDescription() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    CollectionReference usersRef = _firestore.collection("Users");
    var userRef = usersRef.doc(firebaseUser.uid);
    var response = await userRef.get();
    setState(() {
      map = response.data();
    });
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  FlutterFireAuthService _service = FlutterFireAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Bilgilerim",
            ),
            backgroundColor: Colors.brown[300]),
        body: SingleChildScrollView(
          child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                        color: Colors.white,
                        child: new Container(
                            padding: new EdgeInsets.all(10.0),
                            child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: map["name"],
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                  new TextFormField(
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      hintText: map["phonenumber"],
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                  new TextFormField(
                                    enabled: false,
                                    initialValue: map["email"],
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                  new TextFormField(
                                    enabled: false,
                                    initialValue: map["password"],
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ]))),
                    new Container(
                      padding: new EdgeInsets.only(top: 50.0, bottom: 50),
                      child: new Column(children: <Widget>[
                        MaterialButton(
                          onPressed: () => {},
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.lock),
                              Text("Şifre Değiştir",
                                  style: new TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ]),
                    ),
                    new Container(
                      padding: new EdgeInsets.all(50),
                      child: new Column(children: <Widget>[
                        new MaterialButton(
                          onPressed: () => {
                            _service.updateUser(
                                nameController.text, phoneController.text)
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          //height: 100,
                          color: Colors.grey,
                          child: Text("Güncelle",
                              style: new TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    )
                  ])),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adreseklepage.dart';
import 'package:kullanicigirisitest/screens/KartlarSayfasi/karteklepage.dart';
import 'package:kullanicigirisitest/screens/SepetlerSayfasi/sepetlerservis.dart';
import 'package:kullanicigirisitest/screens/SiparislerSayfasi/siparislerimpage.dart';
import 'package:kullanicigirisitest/screens/SiparislerSayfasi/siparislerservis.dart';

class odemePage extends StatefulWidget {
  final String totalPrice;
  const odemePage({Key key, this.totalPrice}) : super(key: key);

  @override
  _odemePageState createState() => _odemePageState();
}

class _odemePageState extends State<odemePage> {
  SiparisService _service = SiparisService();
  CartService _cartService = CartService();
  String _dropdownValueAdres;
  String _dropdownValueKart;
  final _firestore = FirebaseFirestore.instance;
  List<String> Adresliste = [];
  List<String> Kartliste = [];
  @override
  void initState() {
    super.initState();
    adreskartGetir();
  }

  void adreskartGetir() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection("Adres")
        //.where("baslik")
        .get()
        .then((QuerySnapshot ds) {
      Adresliste.clear();
      var map = ds.docs.asMap();
      for (var i = 0; i < map.length; i++) {
        setState(() {
          Adresliste.add(map[i]["baslik"]);
        });
      }
    });
    _firestore
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection("Kart")
        //.where("baslik")
        .get()
        .then((QuerySnapshot ds) {
      Kartliste.clear();
      var map = ds.docs.asMap();
      for (var i = 0; i < map.length; i++) {
        setState(() {
          Kartliste.add(map[i]["kullaniciadi"]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      adreskartGetir();
    });
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown[300], title: Text("Ödeme")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _dropdownValueAdres,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    width: 150,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: Adresliste.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  hint: Text('Adres seçin'),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownValueAdres = newValue;
                    });
                  },
                ),
                MaterialButton(
                    color: Colors.brown[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adreseklePage()));
                    },
                    child: Text("Adres Ekle"))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _dropdownValueKart,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 30,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  items: Kartliste.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  hint: Text('Kart Seçin'),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownValueKart = newValue;
                    });
                  },
                ),
                MaterialButton(
                    color: Colors.brown[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => karteklePage()));
                    },
                    child: Text("Kart Ekle"))
              ],
            ),
            SizedBox(height: 15),
            Text("Toplam: " + widget.totalPrice + " ₺"),
            SizedBox(height: 15),
            MaterialButton(
                color: Colors.brown[300],
                onPressed: () {
                  _service.addSiparis(_dropdownValueAdres, _dropdownValueKart,
                      widget.totalPrice, "Hazırlanıyor");
                  _cartService.deleteCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => siparislerimPage()));
                },
                child: Text("onayla"))
          ],
        ),
      ),
    );
  }
}

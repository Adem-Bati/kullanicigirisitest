import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adreslerimpage.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/bigilerimpage.dart';
import 'package:kullanicigirisitest/screens/SiparislerSayfasi/siparislerimpage.dart';
import 'package:kullanicigirisitest/screens/hakkindapage.dart';
import 'package:kullanicigirisitest/screens/KartlarSayfasi/kredikartpage.dart';

class DigerPage extends StatefulWidget {
  const DigerPage({Key key}) : super(key: key);

  @override
  _DigerPageState createState() => _DigerPageState();
}

class _DigerPageState extends State<DigerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          title: Text("Diğer"),
        ),
        body: _diger(context));
  }

  Widget _diger(context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BilgilerimPage()),
              //ad.text = "ad",
            ),
          },
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          height: 100,
          child: Row(
            children: <Widget>[Icon(Icons.perm_identity), Text("Bilgilerim")],
          ),
        ),

//------------------------------------------------------------------------------

        MaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdreslerimPage()),
            ),
          },
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          height: 100,
          child: Row(
            children: <Widget>[Icon(Icons.add_location), Text("Adreslerim")],
          ),
        ),

//------------------------------------------------------------------------------

        MaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => krediPage()),
            ),
          },
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          height: 100,
          child: Row(
            children: <Widget>[
              Icon(Icons.credit_card),
              Text("Kredi Kartlarım")
            ],
          ),
        ),

//------------------------------------------------------------------------------

        MaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HakkindaPage()),
            ),
          },
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          height: 100,
          child: Row(
            children: <Widget>[
              Icon(Icons.info),
              Text(
                "Uygulama Hakkında",
              )
            ],
          ),
        ),

        //------------------------------------------------------------------------------

        MaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => siparislerimPage()),
            ),
          },
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          height: 100,
          child: Row(
            children: <Widget>[
              Icon(Icons.shopping_basket),
              Text(
                "Siparişlerim",
              )
            ],
          ),
        ),

//------------------------------------------------------------------------------

        Container(
          padding: new EdgeInsets.all(50),
          child: MaterialButton(
            onPressed: () {
              // print('çıkış yapıldı');
              // context.read<FlutterFireAuthService>().signOut();
              // if (Navigator.of(context).canPop()) {
              //   Navigator.of(context).pop();
              // }

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Giris_Ekran()),
              // ),
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: new EdgeInsets.all(10.0),
            color: Colors.grey,
            child: Text("Güvenli Çıkış",
                style:
                    new TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicigirisitest/screens/KartlarSayfasi/kartlarservis.dart';

class karteklePage extends StatefulWidget {
  const karteklePage({Key key}) : super(key: key);

  @override
  _karteklePageState createState() => _karteklePageState();
}

class _karteklePageState extends State<karteklePage> {
  KartService _service = KartService();
  final TextEditingController kullaniciadiController = TextEditingController();
  final TextEditingController kartnumaraController = TextEditingController();
  final TextEditingController tarihController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Adres Ekle")),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: size.height * .4,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                      controller: kullaniciadiController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Kullanici Adı yazın...",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: kartnumaraController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Kart Numarası yazın...",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: tarihController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Tarih yazın...",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: cvvController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Cvv yazın...",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _service
                      .addKart(
                          kullaniciadiController.text,
                          kartnumaraController.text,
                          tarihController.text,
                          cvvController.text)
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
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      //color: colorPrimaryShade,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Text(
                      "Ekle",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ]),
    );
  }
}

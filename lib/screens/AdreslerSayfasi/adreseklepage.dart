import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adreslerservis.dart';

class adreseklePage extends StatefulWidget {
  const adreseklePage({Key key}) : super(key: key);

  @override
  _adreseklePageState createState() => _adreseklePageState();
}

class _adreseklePageState extends State<adreseklePage> {
  AdresService _service = AdresService();
  final TextEditingController baslikController = TextEditingController();
  final TextEditingController sehirilceController = TextEditingController();
  final TextEditingController mahalleController = TextEditingController();
  final TextEditingController aciklamaController = TextEditingController();

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
                      controller: baslikController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "başlık yazın...",
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
                      controller: sehirilceController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Şehir/İlçe yazın...",
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
                      controller: mahalleController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Mahalle yazın...",
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
                      controller: aciklamaController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Adres yazın...",
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
                      .addAdres(baslikController.text, sehirilceController.text,
                          mahalleController.text, aciklamaController.text)
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

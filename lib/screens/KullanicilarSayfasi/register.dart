import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicigirisitest/bottomnavbar/bottomnavbar.dart';
import 'package:kullanicigirisitest/screens/fadeanimasyon.dart';

import 'firebase.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();

  FlutterFireAuthService _auth = FlutterFireAuthService();

  @override
  Widget build(BuildContext context) {
    bool checkBoxValue = false;

//-----Cep-Telefonu-TextField-----

    final cepTelefonu_Text = TextField(
      obscureText: false,
      controller: phonenumberController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Cep Telefonu",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.flag),
        prefixText: "(+90)",
      ),
    );

//-----E-Posta-TextField-----

    final ePosta_Text = TextField(
      obscureText: false,
      controller: emailController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "E-Posta",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//-----Sifre-Textfield-----

    final sifre_Text = TextField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Şifre",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//-----Sifre-Tekrar-Textfield-----

    final sifreTekrar_Text = TextField(
      obscureText: true,
      controller: password2Controller,
      onChanged: (String value) {},
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Şifre Tekrar",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//-----Ad-Soyad-Textfield-----

    final adSoyad_Text = TextField(
      obscureText: false,
      controller: nameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Ad Soyad",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//-----Kayıt-Ol-Button-----

    final kayitOlButton = Material(
      elevation: 36.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (passwordController.text == password2Controller.text) {
            _auth
                .signUp(nameController.text, phonenumberController.text,
                    emailController.text, passwordController.text)
                .then((value) {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            });
          } else {
            Fluttertoast.showToast(
                msg: "SifreTekrar Hatalı",
                timeInSecForIosWeb: 2,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 14);
          }
        },
        child: Text("Kayıt ol",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontStyle: FontStyle.normal)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text(
          "Kayıt Ol",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(1.0, cepTelefonu_Text),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.2, ePosta_Text),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.4, adSoyad_Text),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.6, sifre_Text),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.8, sifreTekrar_Text),
                  SizedBox(height: 15.0),
                  FadeAnimation(
                      2.0,
                      Row(children: <Widget>[
                        Checkbox(
                            value: checkBoxValue,
                            activeColor: Colors.brown[300],
                            onChanged: (bool newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            }),
                        Flexible(
                            child: Text(
                                "Bana özel kampanya, tanıtım ve fırsatlardan haberdar olmak istiyorum.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15)))
                      ])),
                  SizedBox(height: 15.0),
                  FadeAnimation(
                      2.2,
                      Row(children: <Widget>[
                        SizedBox(width: 5.0),
                        Flexible(
                            child: Text(
                                "Kayıt olarak Kullanım Koşullarını onaylamış olursunuz.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15)))
                      ])),
                  SizedBox(height: 15.0),
                  FadeAnimation(2.4, kayitOlButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

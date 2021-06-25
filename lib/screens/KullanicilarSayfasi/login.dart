import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicigirisitest/bottomnavbar/bottomnavbar.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/register.dart';
import 'package:kullanicigirisitest/screens/fadeanimasyon.dart';

import 'firebase.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FlutterFireAuthService _auth = FlutterFireAuthService();

  @override
  Widget build(BuildContext context) {
    //MessageBox oluşturma
    // void _showAlertDialog(String message) async {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(message),
    //         actions: <Widget>[
    //           MaterialButton(
    //             child: Text('Tamam'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

//------------------------------------------------------------------------------

    final e_Posta_text = TextField(
      obscureText: false,
      controller: emailController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "E Mail",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//------------------------------------------------------------------------------

    final sifre_text = TextField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Şifre",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

//------------------------------------------------------------------------------
    var size = MediaQuery.of(context).size;
    final girisYapButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          try {
            _auth
                .signIn(emailController.text, passwordController.text)
                .then((value) {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            });
          } on Exception catch (e) {
            print(e);
          }

          emailController.clear();
          passwordController.clear();
        },
        child: Text(
          "Giriş yap",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );

//------------------------------------------------------------------------------

    final kayitOlButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterView()),
          );
        },
        child: Text(
          "Kayıt ol",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );

//------------------------------------------------------------------------------

    final sifremiUnuttumButton = Material(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );*/
        },
        child: Text(
          "Şifremi Unuttum",
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Colors.brown[300], fontStyle: FontStyle.normal),
        ),
      ),
    );

//------------------------------------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text(
          "Giriş Ekranı",
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
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.4,
                    child:
                        Image(image: AssetImage("images/yuklemekranlogo.png")),
                  ),
                  SizedBox(height: 60.0),
                  FadeAnimation(1.0, e_Posta_text),
                  SizedBox(height: 10.0),
                  FadeAnimation(1.2, sifre_text),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.4, girisYapButton),
                  SizedBox(height: 15.0),
                  FadeAnimation(1.6, kayitOlButton),
                  SizedBox(height: 25.0),
                  FadeAnimation(1.8, sifremiUnuttumButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

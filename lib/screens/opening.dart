import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/sliderpage.dart';

class OpeningView extends StatefulWidget {
  OpeningView({Key key}) : super(key: key);

  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> {
  @override
  void initState() {
    super.initState();

    //Ekranı build olduktan 5 saniye sonra hedef sayfaya atar
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SliderPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: new CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                child: Image.asset('images/yuklemekranlogo.png'),
              )),
              SizedBox(
                height: 40,
              ),
              Container(
                  child: new CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: Image.asset('images/loader.gif'),
              )),
            ],
          ),
        )),
      ),
    );
  }
}

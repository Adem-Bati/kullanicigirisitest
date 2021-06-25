import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:kullanicigirisitest/screens/KullanicilarSayfasi/login.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          Container(
            height: size.height * 0.6,
            //Carousel bölgede birden falza resim göstererek aralarında geçiş yapabilmemizi sağlar
            child: Carousel(
              boxFit: BoxFit.cover,
              showIndicator: false,
              animationDuration: Duration(milliseconds: 600),
              images: [
                AssetImage('images/slider4.jpg'),
                AssetImage('images/slider7.jpg'),
                AssetImage('images/slider8.jpg')
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: Opacity(
                    opacity: 1.0,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.brown[300]),
                    ),
                  ),
                );
              });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        },
        label: Text('Başla'),
        icon: Icon(Icons.arrow_right),
        backgroundColor: Colors.brown[300],
        elevation: 10,
      ),
    );
  }
}

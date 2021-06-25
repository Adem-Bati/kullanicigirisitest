import 'package:flutter/material.dart';

class HakkindaPage extends StatefulWidget {
  const HakkindaPage({Key key}) : super(key: key);

  @override
  _HakkindaPageState createState() => _HakkindaPageState();
}

class _HakkindaPageState extends State<HakkindaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hakkında",
        ),
        backgroundColor: Colors.brown[300],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3311456 kodlu Mobil Programlama dersi kapsamında 183311072 numaralı Adem BATI tarafından 24.06.2021 günü yapılmıştır.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

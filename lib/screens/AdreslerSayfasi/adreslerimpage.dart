import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adreslerservis.dart';
import 'package:kullanicigirisitest/screens/AdreslerSayfasi/adreseklepage.dart';

class AdreslerimPage extends StatefulWidget {
  const AdreslerimPage({Key key}) : super(key: key);

  @override
  _AdreslerimPageState createState() => _AdreslerimPageState();
}

class _AdreslerimPageState extends State<AdreslerimPage> {
  AdresService _service = AdresService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adreseklePage()));
                    },
                    label: Text('Ekle'),
                    icon: Icon(Icons.plus_one),
                    backgroundColor: Colors.brown[300],
                    //elevation: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: Text(
            "Adreslerim",
          ),
          backgroundColor: Colors.brown[300]),
      body: StreamBuilder(
        stream: _service.getAdres(),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data.documents[index];

                    Future<void> _showChoiseDialog(BuildContext context) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(
                                  "Silmek istediğinize emin misiniz?",
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                content: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            _service.removeAdres(mypost.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Evet",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Vazgeç",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )));
                          });
                    }

                    return Container(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: ListTile(
                          onTap: () {
                            _showChoiseDialog(context);
                          },
                          title: Text(mypost["baslik"]),
                          subtitle: Text(mypost["sehirilce"] +
                              "\n" +
                              mypost["mahalle"] +
                              "\n" +
                              mypost["aciklama"]),
                          leading: Icon(Icons.home),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}

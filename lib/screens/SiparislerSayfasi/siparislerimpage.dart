import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/SiparislerSayfasi/siparislerservis.dart';

class siparislerimPage extends StatefulWidget {
  const siparislerimPage({Key key}) : super(key: key);

  @override
  _siparislerimPageState createState() => _siparislerimPageState();
}

class _siparislerimPageState extends State<siparislerimPage> {
  SiparisService _service = SiparisService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          title: Text("Siparişlerim"),
        ),
        body: StreamBuilder(
            stream: _service.getSiparis(),
            builder: (context, snaphot) {
              return !snaphot.hasData
                  ? Center(
                      child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.brown[300]),
                    ))
                  : ListView.builder(
                      itemCount: snaphot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot mypost = snaphot.data.documents[index];
                        Future<void> _showAlertDialog(BuildContext) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Ürün sepetten çıkarılsın mı?"),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                          onTap: () {}, child: Text("Evet")),
                                      InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Text("Hayır")),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: ListTile(
                            onTap: () {},
                            title: Text(mypost["durum"]),
                            subtitle: Text(mypost["adres"] +
                                "\n" +
                                mypost["kart"] +
                                "\n" +
                                mypost["ucret"] +
                                " ₺"),
                            leading: Icon(Icons.shopping_bag),
                          ),
                        );
                      });
            }));
  }
}

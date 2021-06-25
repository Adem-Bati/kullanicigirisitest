import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/screens/KampanyalarSayfasi/kampanyalarservis.dart';

class denemeKampanya extends StatefulWidget {
  const denemeKampanya({Key key}) : super(key: key);

  @override
  _denemeKampanyaState createState() => _denemeKampanyaState();
}

class _denemeKampanyaState extends State<denemeKampanya> {
  KampanyaService _service = KampanyaService();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController pnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  PickedFile profileImage;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return Container(
        height: 70,
        width: 80,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: FileImage(File(profileImage.path)), fit: BoxFit.cover)),
      );
    } else {
      if (_pickImage != null) {
        return Container(
          height: 70,
          width: 80,
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(_pickImage), fit: BoxFit.cover)),
        );
      } else {
        Container(
          height: 70,
          width: 80,
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage("images/default.png"), fit: BoxFit.cover)),
        );
      }
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.getImage(
        source: source,
      );
      setState(() {
        profileImage = pickedFile;
        print("dosyaya geldim: $profileImage");
        if (profileImage != null) {}
      });
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      Center(
                        child: imagePlace(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.camera,
                                  context: context),
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.blue,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context),
                              child: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                      TextField(
                          controller: pnameController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "title yazın...",
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
                          controller: descriptionController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "tag yazın...",
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
              child: InkWell(
                onTap: () {
                  _service
                      .addKampanya(pnameController.text,
                          descriptionController.text, profileImage)
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
            ),
          ])),
      body: StreamBuilder(
        stream: _service.getKampanya(),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data.documents[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * .3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mypost['pname'],
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: size.height * 0.19,
                                width: size.height * 0.50,
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: mypost['image'] == ""
                                            ? AssetImage("images/default.png")
                                            : NetworkImage(mypost['image']),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                mypost['description'],
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kullanicigirisitest/screens/UrunlerSayfasi/urunlerservis.dart';

import 'package:kullanicigirisitest/screens/UrunlerSayfasi/productdetailspage.dart';

class denemeProduct extends StatefulWidget {
  final String title;
  final String catImage;
  final String tag;
  final String urunk;
  const denemeProduct(
      {Key key, this.title, this.catImage, this.tag, this.urunk})
      : super(key: key);

  @override
  _denemeProductState createState() => _denemeProductState();
}

class _denemeProductState extends State<denemeProduct> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pidController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController pnameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  ProductsService _service = ProductsService();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  PickedFile profileImage;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return Container(
        height: 140,
        width: 160,
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
          height: 140,
          width: 160,
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(_pickImage), fit: BoxFit.cover)),
        );
      } else {
        Container(
          height: 140,
          width: 160,
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
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * .7,
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
                            controller: categoryController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "Kategoriyi yazın...",
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
                        TextField(
                            controller: descriptionController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "Açıklama yazın...",
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
                        TextField(
                            controller: pidController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "pid yazın...",
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
                        TextField(
                            controller: pnameController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "pname yazın...",
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
                        TextField(
                            controller: priceController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "price yazın...",
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
                        TextField(
                            controller: typeController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "type yazın...",
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
                        .addCategory(
                            categoryController.text,
                            descriptionController.text,
                            profileImage,
                            pidController.text,
                            pnameController.text,
                            priceController.text,
                            typeController.text)
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
            ]))),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: BackButton(color: Colors.white),
                  automaticallyImplyLeading: false,
                  title: new Text(widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  expandedHeight: 140,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.catImage == ""
                                  ? AssetImage("images/default.png")
                                  : NetworkImage(widget.catImage),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.0),
                              Colors.black.withOpacity(.6),
                            ])),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: StreamBuilder(
                stream: _service.getProducts(widget.title),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.brown[300]),
                        ))
                      : GridView.builder(
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot mypost =
                                snapshot.data.documents[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            denemeProductDetails(
                                              image: mypost['image'],
                                              description:
                                                  mypost['description'],
                                              pid: mypost['pid'],
                                              pname: mypost['pname'],
                                              price: mypost['price'],
                                              type: mypost['type'],
                                              category: mypost['category'],
                                              profileImage: profileImage,
                                            )));
                              },
                              onLongPress: () {
                                _service.removeProduct(mypost.id);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 140,
                                              width: 160,
                                              margin: EdgeInsets.only(
                                                  right: 10, bottom: 10),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: mypost['image'] ==
                                                              ""
                                                          ? AssetImage(
                                                              "images/default.png")
                                                          : NetworkImage(
                                                              mypost['image']),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Positioned(
                                                left: 0,
                                                bottom: 0,
                                                width: 140,
                                                height: 30,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "           %10 indirim"),
                                                )),
                                            //               Positioned(
                                            // left: 10,
                                            // bottom: 115,
                                            // right: 10,
                                            // child: Row(
                                            //   mainAxisSize: MainAxisSize.max,
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: <Widget>[

                                            //   ],))
                                          ],
                                        )),
                                    Text(
                                      "${mypost['pname']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                })));
  }
}

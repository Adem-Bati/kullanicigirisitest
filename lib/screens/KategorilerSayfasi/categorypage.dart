import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kullanicigirisitest/screens/KategorilerSayfasi/categoriesservice.dart';
import 'package:kullanicigirisitest/screens/UrunlerSayfasi/productdetailspage.dart';
import 'package:kullanicigirisitest/screens/UrunlerSayfasi/productpage.dart';
import 'package:kullanicigirisitest/screens/UrunlerSayfasi/urunlerservis.dart';
import 'package:kullanicigirisitest/screens/fadeanimasyon.dart';

class denemeCategory extends StatefulWidget {
  const denemeCategory({Key key}) : super(key: key);

  @override
  _denemeCategoryState createState() => _denemeCategoryState();
}

class _denemeCategoryState extends State<denemeCategory> {
  final TextEditingController imageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  CategoriesService _service = CategoriesService();
  ProductsService _productsService = ProductsService();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

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

  final TextEditingController araController = TextEditingController();
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
                            controller: titleController,
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
                            controller: tagController,
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
                        .addCategory(titleController.text, tagController.text,
                            profileImage)
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
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: SimpleAutoCompleteTextField(
                              controller: araController,
                              key: key,
                              suggestions: [
                                "Sigara",
                                "Cipsi",
                                "Bulaşık Deterjanı",
                                "Sarı Bez",
                                "Fıstık",
                                "Fındık",
                                "Şampuan",
                                "Diş Macunu",
                                "Duş Jeli",
                                "Çamaşır Suyu",
                                "Kola",
                                "Meyve Suyu",
                                "Soda",
                                "Süt",
                                "Peynir",
                                "Kavurma",
                              ],
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ara",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 0,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.black,
                                  icon: Icon(Icons.search),
                                  onPressed: () {},
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background: new SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Carousel(
                        images: [
                          AssetImage("images/slider10.jpg"),
                          AssetImage("images/slider11.jpg"),
                          AssetImage("images/slider12.jpg"),
                          AssetImage("images/slider16.jpg"),
                        ],
                        dotBgColor: Colors.transparent,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: araController.text == ""
                ? StreamBuilder(
                    stream: _service.getCategories(),
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
                                      crossAxisCount: 3),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot mypost =
                                    snapshot.data.documents[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => denemeProduct(
                                                catImage: mypost['image'],
                                                title: mypost['title'],
                                                tag: mypost['tag'])));
                                  },
                                  onLongPress: () {
                                    _service.removeCategories(mypost.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 70,
                                                  width: 80,
                                                  margin: EdgeInsets.only(
                                                      right: 10, bottom: 10),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                          image: mypost[
                                                                      'image'] ==
                                                                  ""
                                                              ? AssetImage(
                                                                  "images/default.png")
                                                              : NetworkImage(
                                                                  mypost[
                                                                      'image']),
                                                          fit: BoxFit.cover)),
                                                ),
                                                // Positioned(
                                                //     left: 0,
                                                //     bottom: 0,
                                                //     width: 140,
                                                //     height: 30,
                                                //     child: Container(
                                                //         decoration: BoxDecoration(
                                                //       color: Colors.black,
                                                //     ))),
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
                                          "${mypost['title']}",
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
                    })
                : StreamBuilder(
                    stream:
                        _productsService.getProductsSearch(araController.text),
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
                                                    category:
                                                        mypost['category'])));
                                  },
                                  onLongPress: () {
                                    _productsService.removeProduct(mypost.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                          image: mypost[
                                                                      'image'] ==
                                                                  ""
                                                              ? AssetImage(
                                                                  "images/default.png")
                                                              : NetworkImage(
                                                                  mypost[
                                                                      'image']),
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
                                                          "            %10 indirim"),
                                                    )),
                                                // Positioned(
                                                //     left: 10,
                                                //     bottom: 115,
                                                //     right: 10,
                                                //     child: Row(
                                                //       mainAxisSize:
                                                //           MainAxisSize.max,
                                                //       mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .spaceBetween,
                                                //       children: <Widget>[],
                                                //     ))
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

import 'dart:collection';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadData extends StatefulWidget {
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  File imageFile;
  var formKey = GlobalKey<FormState>();
  String desain, ukuran, harga;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000725),
      appBar: AppBar(
        backgroundColor: Color(0xffff2fc3),
        title: Text(
          "Upload Data",
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15)),
              Container(
                child: imageFile == null
                    ? FlatButton(
                        onPressed: () {
                          _showDialog();
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 80,
                          color: Color(0xffff2fc3),
                        ))
                    : Image.file(
                        imageFile,
                        width: 400,
                        height: 400,
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Silahkan tulis nama desain ";
                          } else {
                            desain = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Desain by",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Silahkan tulis ukurannya";
                          } else {
                            ukuran = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "ukuran",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Silahkan tulis harga";
                          } else {
                            harga = value;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Harga",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color(0xffff2fc3), width: 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  if (imageFile == null) {
                    Fluttertoast.showToast(
                        msg: "Please select an image",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 2);
                  } else {
                    upload();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xffff2fc3),
                child: Text(
                  "Upload",
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("You want take a photo from?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      openGallary();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> openGallary() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
  }

  Future<void> openCamera() async {
    var picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
  }

  Future<void> upload() async {
    if (formKey.currentState.validate()) {
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageFile.path);
      StorageUploadTask uploadTask = reference.putFile(imageFile);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = imageUrl.toString();
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("Data");
      String uploadId = databaseReference.push().key;
      HashMap map = new HashMap();
      map["desain"] = desain;
      map["ukuran"] = ukuran;
      map["harga"] = harga;
      map["imgUrl"] = url;

      databaseReference.child(uploadId).set(map);
    }
  }
}

import 'dart:async';

import 'package:app_arsitek/Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyFavorite extends StatefulWidget {
  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  List<Data> dataList = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    FavoriteFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Favorite",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffff2fc3),
      ),
      body: dataList.length == 0
          ? Center(
              child: Text(
              "No Desain Available",
              style: TextStyle(fontSize: 30),
            ))
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (_, index) {
                return CardUI(
                    dataList[index].imgUrl,
                    dataList[index].desain,
                    dataList[index].ukuran,
                    dataList[index].harga,
                    dataList[index].uploadid,
                    index);
              },
            ),
    );
  }

  Widget CardUI(String imgUrl, String desain, String ukuran, String harga,
      String uploadid, int index) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(15),
      color: Color(0xffff2fc3),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.network(
              imgUrl,
              fit: BoxFit.cover,
              height: 100,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              desain,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1,
            ),
            Text("Ukuran:- $ukuran"),
            SizedBox(
              height: 1,
            ),
            Container(
              width: double.infinity,
              child: Text(
                harga,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  auth.currentUser().then((value) {
                    DatabaseReference favRef = FirebaseDatabase.instance
                        .reference()
                        .child("Data")
                        .child(uploadid)
                        .child("Fav")
                        .child(value.uid)
                        .child("state");
                    favRef.set("false");
                    setState(() {
                      FavoriteFunc();
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }

  void FavoriteFunc() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();

      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Data data = new Data(values[key]["imgUrl"], values[key]["desain"],
            values[key]["ukuran"], values[key]["harga"], key);

        auth.currentUser().then((value) {
          DatabaseReference reference = FirebaseDatabase.instance
              .reference()
              .child("Data")
              .child(key)
              .child("Fav")
              .child(value.uid)
              .child("state");
          reference.once().then((DataSnapshot snapShot) {
            if (snapShot.value != null) {
              if (snapShot.value == "true") {
                dataList.add(data);
              }
            }
          });
        });
      }
      Timer(Duration(seconds: 1), () {
        setState(() {
          //
        });
      });
    });
  }
}

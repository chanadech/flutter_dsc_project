import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter_dsc_project/authentication_guest.dart';
import 'package:flutter_dsc_project/page_example_loadData.dart';
import 'package:flutter_dsc_project/router_page.dart';
import 'package:http/http.dart' as http;
import 'custom_dialog_box.dart';
import 'model/Ownerlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageExampleLoadDataItemGuess extends StatefulWidget {
  final List<Data> dataList;

  PageExampleLoadDataItemGuess({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  PageExampleLoadDataItemGuessState createState() =>
      PageExampleLoadDataItemGuessState();
}

class PageExampleLoadDataItemGuessState
    extends State<PageExampleLoadDataItemGuess> {
  List<Ownerlist> _transactions = [];

  @override
  void initState() {
    _transactions = _getdata() as List<Ownerlist>;
    super.initState();
  }

  void _navigateToStudent() {
    //implement function here
    print("Holyshit");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationGuest()),
    );
    print("Holyshit2");
  }

  // void _detailPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PageDetail()),
  //   );
  // }

 _getdata() {
   final List<Ownerlist> transaction = [];
    FirebaseFirestore.instance //Collecting personal stuff
        .collection('user').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // loop key value ทื่ได้มาแล้วค่อยไปใส่ใน transaction หรือ ใน list ของ object ของเรา ให้ถูกต้อง
        // print("ProductData: $prodData");

        transaction.add(Ownerlist(
            // ปรับแค่ตอนสร้าง object
            id: doc["id"],
            name: doc["name"],
            email: doc["email"]));
        setState(() {
          this._transactions = transaction;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: _transactions
                          ?.map(
                            (entry) => new ListTile(
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.blueGrey))),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://www.pngfind.com/pngs/m/470-4703547_icon-user-icon-hd-png-download.png"),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(entry.name.toString()),
                              subtitle: Text(entry.email.toString()),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _navigateToStudent();
                                print("testza");
                              },
                              // selected: false,
                            ),
                          )
                          ?.toList() ??
                      [],
                ),
              ],
            )),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class Data {
  final int id;
  bool expanded;
  final String title;

  Data(this.id, this.expanded, this.title);
}

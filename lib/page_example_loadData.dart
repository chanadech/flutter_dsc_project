import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:http/http.dart' as http;
import 'custom_dialog_box.dart';
import 'model/Filelist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class PageExampleLoadDataItem extends StatefulWidget {
  final List<Data> dataList;

  PageExampleLoadDataItem({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  PageExampleLoadDataItemState createState() => PageExampleLoadDataItemState();
}

class PageExampleLoadDataItemState extends State<PageExampleLoadDataItem> {
  List<Filelist> _transactions = []; ////Edit Adap model class which should be our data
  var isOwner;

  @override
  void initState() {
    _transactions = _getdata(); // receive data from api when start app
    super.initState();
  }

  // void _detailPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PageDetail()),
  //   );
  // }

  _getdata() {
    final List<Filelist> transaction = [];
    FirebaseFirestore.instance //Collecting personal stuff
        .collection('user')
        .where('email', isEqualTo: user.email).get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // loop key value ทื่ได้มาแล้วค่อยไปใส่ใน transaction หรือ ใน list ของ object ของเรา ให้ถูกต้อง
        // print("ProductData: $prodData");

        transaction.add(Filelist(
          // ปรับแค่ตอนสร้าง object
            name: doc["fname"],
            link: doc["flink"]));
        setState(() {
          this._transactions = transaction;
        });
        transaction.add(Filelist(
          // ปรับแค่ตอนสร้าง object
            name: doc["fname2"],
            link: doc["flink2"]));
        setState(() {
          this._transactions = transaction;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    isOwner =
        true; //// Edit State when login checking user type that true or false

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          //// Implement here- Edit State when login checking user type that true or false
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showCustomDialogBox(context);
            },
          ),
          visible: isOwner,
        ),
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
                                      "https://www.iconpacks.net/icons/2/free-pdf-download-icon-3388-thumb.png"),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(entry.name),
                              subtitle: Text(entry.link.toString()),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap:() async {
                                print("opendownloadlink");
                                const url = "https://firebasestorage.googleapis.com/v0/b/s23d-andweb-th.appspot.com/o/61090033%2Fpond_kindergarten_transcript.pdf?alt=media&token=a164f29c-6df5-4e7b-bf87-17dc9a1ff56f";
                                if (await canLaunch(url))
                                await launch(url);
                                else
                                // can't launch url, there is some error
                                throw "Could not launch $url";
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

class Data {
  final int id;
  bool expanded;
  final String title;

  Data(this.id, this.expanded, this.title);
}

showCustomDialogBox(BuildContext context) {
  return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          child: child,
          scale: Tween<double>(end: 1.0, begin: 0).animate(CurvedAnimation(
              parent: animation,
              curve: Interval(0.00, 0.50, curve: Curves.linear))),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialogBox();
      });
}

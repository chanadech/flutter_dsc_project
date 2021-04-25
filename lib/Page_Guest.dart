import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter_dsc_project/authentication_guest.dart';
import 'package:flutter_dsc_project/page_example_loadData.dart';
import 'package:flutter_dsc_project/router_page.dart';
import 'package:http/http.dart' as http;
import 'custom_dialog_box.dart';
import 'model/modelMock.dart';

class PageExampleLoadDataItemGuess extends StatefulWidget {
  final List<Data> dataList;

  PageExampleLoadDataItemGuess({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  PageExampleLoadDataItemGuessState createState() => PageExampleLoadDataItemGuessState();
}

class PageExampleLoadDataItemGuessState extends State<PageExampleLoadDataItemGuess> {
  // List<String> items = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"];
  List<ModelMock> _transactions = [];


  @override
  void initState() {
    _transactions = _getdata();
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

  List _getdata() {
    http
        .get(
      //get ไปเอาข้อมูลที่เดิม แต่ส่งแบบ get แทน
      Uri.parse(
          "https://labtest-68c7d-default-rtdb.firebaseio.com/teamsoft.json"), //return Futre <Response> --> เอา data จาก future ใข้ .then
    )
        .then((response) {
      print(response.body); // ไดข้อมูลมาแล้วว จาก console ด้านล่าง
      final extractedData = json.decode(response.body) as Map<String,
          dynamic>; //parse data จาก firebase ไปใส่ใน list  ของ object ก๊อปไปได้เลย ใช้ http get นะ
      final List<ModelMock> transaction = [];
      extractedData.forEach((prodId, prodData) {
        // loop key value ทื่ได้มาแล้วค่อยไปใส่ใน transaction หรือ ใน list ของ object ของเรา ให้ถูกต้อง
        // print("ProductData: $prodData");
        transaction.add(ModelMock(
          // ปรับแค่ตอนสร้าง object
            description: prodData['description'],
            title: prodData['title'],
            date: DateTime.now(),
            id: prodData['id']));

        setState(() {
          this._transactions = transaction;
        });
      });
      print(transaction);
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
                      title: Text(entry.description),
                      subtitle: Text(entry.title.toString()),
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

class Data {
  final int id;
  bool expanded;
  final String title;

  Data(this.id, this.expanded, this.title);
}

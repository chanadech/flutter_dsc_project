import 'package:flutter/material.dart';
import 'package:flutter_dsc_project/router_page.dart';

import 'main.dart';

class PageTwo extends StatefulWidget {
  final List<Data> dataList;
  PageTwo({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {

  void _logout() {
    //implement function here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.00, horizontal: 10.00),
                  child: CircleAvatar(
                    backgroundImage:
                    NetworkImage( "https://www.pngfind.com/pngs/m/470-4703547_icon-user-icon-hd-png-download.png"),
                    backgroundColor: Colors.blue,
                    radius: 100.0,

                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Chanadech",
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("dachboy@hotmail.com",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20.0),
                children: <Widget>[
                  FlatButton(
                    child: ProfileListItem(
                      icon: Icons.exit_to_app_rounded,
                      text: 'Logout',
                    ),
                    onPressed: (){
                      _logout();
                    },
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: 20
      ).copyWith(
        bottom: 10.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      ),
      child: Row(
        children: [
          Icon(
            this.icon,
            size: 24.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dsc_project/Page_Guest.dart';
import 'package:flutter_dsc_project/authentication.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'router_page.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User user;
String mfa;
String username;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  void _loginGuest() {
    //implement function here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageExampleLoadDataItemGuess()),
    );
  }



  void _login() {
    //implement function here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouterManager()),
    );
    // http
    //     .get('https://labflutter-3b9e2.firebaseio.com/user.json')
    //     .then((value) {
    //       // print("##object");
    //       print(value.body);
    //       });

    // _getdata();
  }

  /*
  void _getdata() {
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


*/





  Widget buildLoginButton() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Sign in",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.blueAccent),
      ButtonState.loading:
      IconedButton(text: "Loading", color: Colors.lightBlue),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedLoginAdminButton, state: stateTextWithIcon);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      NetworkImage("https://img.icons8.com/ios/452/school.png"),
                  backgroundColor: Colors.transparent,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  "S23d Project",
                  style: TextStyle(
                      fontFamily: 'SansPro',
                      fontSize: 12,
                      color: Colors.blueAccent.shade200,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: Divider(
                    color: Colors.blueAccent.shade700,
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        title: new TextFormField(
                          controller: _emailField,
                          decoration: new InputDecoration(
                            labelText: "Enter Email",
                            fillColor: Colors.transparent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      )),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.security,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        title: new TextFormField(
                          obscureText: true,
                          controller: _passwordField,
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                            fillColor: Colors.transparent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      )),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // buildCustomButton(),
                        Container(
                          height: 32,
                        ),
                        buildLoginButton(),
                        Container(
                          height: 32,
                        ),
                        // buildTextWithIconWithMinState(),
                      ],
                    ),

                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: ProgressButton.icon(iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: "Login as guest",
                          icon: Icon(Icons.account_balance, color: Colors.white),
                          color: Colors.transparent),
                      ButtonState.loading: IconedButton(
                          text: "Loading", color: Colors.deepPurple.shade700),
                      ButtonState.fail: IconedButton(
                          text: "Failed",
                          icon: Icon(Icons.cancel, color: Colors.white),
                          color: Colors.red.shade300),
                      ButtonState.success: IconedButton(
                          text: "Success",
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          color: Colors.green.shade400)
                    }, onPressed: _loginGuest, state: ButtonState.idle)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPressedLoginAdminButton() async {//back implement here
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        try {
          user = (await _auth.signInWithEmailAndPassword(
            email: _emailField.text,
            password: _passwordField.text,
          )).user;
          if (user != null) {
            print("login success: proceed to 2fa");

            await FirebaseFirestore.instance //Collecting personal stuff
                .collection('user')
                .where('email', isEqualTo: user.email)
                .get()
                .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((doc) {
                mfa = doc["mfa"];
                username = doc["name"];
              });
            });
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authentication()),
            );
            setState(() => ButtonState.success );
            break;
          } else {
            print("login fail: mismatched input");
            setState(() => ButtonState.fail );
            break;
          }
        } catch (e) {
          print("login error: " + e);
        }
        setState(() => ButtonState.fail );
        break;

      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Authentication()),
        );
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }


}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter_dsc_project/page_example_loadData.dart';
import 'package:flutter_dsc_project/router_page.dart';


class Authentication extends StatefulWidget {

  final List<Data> dataList;
  Authentication({
    Key key,
    this.dataList,
  }) : super(key: key);


  @override
  AuthenticationState createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  String code;
  bool loaded;
  bool shake;
  bool valid;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textNode = FocusNode();

  @override
  void initState() {
    super.initState();
    code = '';
    loaded = true;
    shake = false;
    valid = true;
  }

  void onCodeInput(String value) {
    setState(() {
      code = value;
    });
  }

  void _loginAdmin() {
    //implement function here
    print("zaza");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouterManager()),
    );
  }

  Future<void> verifyMfaAndNext() async {
    setState(() {
      loaded = false;

    });
    const bool result = false; //backend call
    setState(() {
      loaded = true;
      valid = result;
    });

    if (valid) {
      // do next
    } else {
      setState(() {
        shake = true;
      });
      await Future<String>.delayed(
          const Duration(milliseconds: 300), () => '1');
      setState(() {
        shake = false;
      });
    }
  }

  List<Widget> getField() {
    final List<Widget> result = <Widget>[];
    for (int i = 1; i <= 6; i++) {
      result.add(
        ShakeAnimatedWidget(
          enabled: shake,
          duration: const Duration(
            milliseconds: 100,
          ),
          shakeAngle: Rotation.deg(
            z: 20,
          ),
          curve: Curves.linear,
          child: Column(
            children: <Widget>[
              if (code.length >= i)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Text(
                    code[i - 1],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Container(
                  height: 5.0,
                  width: 30.0,
                  color: shake ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(60),
                  child: Text(
                    'Verify your phone',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                'Please enter the 6 digit pin.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              if (!valid)
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(
                      60,
                      ),
                      child: Text(
                        'Whoops!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: valid ? 68 : 10,
              ),
              if (!valid)
                Padding(
                  padding: const EdgeInsets.all(
                    60,
                  ),
                  child: Text(
                    'It looks like you entered the wrong pin. Please try again.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 90,
                width: 300,
                // color: Colors.amber,
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.0,
                      child: TextFormField(
                        controller: _controller,
                        focusNode: _textNode,
                        keyboardType: TextInputType.number,
                        onChanged: onCodeInput,
                        maxLength: 6,

                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getField(),
                      ),
                    )
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: _loginAdmin,
                color: Colors.grey,
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
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
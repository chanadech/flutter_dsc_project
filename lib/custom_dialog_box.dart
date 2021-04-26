import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'main.dart';

firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

class CustomDialogBox extends StatelessWidget {
  final double _borderRadius = 20;
  final TextEditingController _filenameField = TextEditingController();
  String studentID;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 80),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Added new portfolio",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  //divider
                  Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        12,
                            (_index) => Container(
                          width: 6,
                          height: 1.5,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Document's name",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          TextField(
                            controller: _filenameField,
                            decoration: InputDecoration(
                                border:  OutlineInputBorder(),
                                hintText: "e.g. High School"
                            ),
                          ),
                          OutlineButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.get_app_sharp),
                                  SizedBox(width: 10.0),
                                  Text("Upload a File")
                                ],
                              ),
                              onPressed:() async {
                                //// DECHI
                                studentID = user.email.substring(0,7);
                                print(studentID);
                              })
                          // Expanded(
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       hintText: "e.g. High School "
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                  ),
                ],
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                bottom: 10,
                child:RaisedButton(
                  elevation: 4,
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => Navigator.pop(context),
                  child: Text("Submit"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ) )
          ],
        ),
      ),
    );
  }
}
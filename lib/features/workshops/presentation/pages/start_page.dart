import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:workshops/features/workshops/presentation/pages/about_page.dart';
import 'package:workshops/features/workshops/presentation/pages/workshops_page.dart';

import 'admin_page.dart';


class StartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Welcome"),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => About()));
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset("assets/info.png"),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -  kToolbarHeight - 25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset("assets/college.png"),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Color(0xffF4D6CC),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          // ignore: deprecated_member_use
                          child: FlatButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WorkshopsPage()));
                              },
                              icon: Icon(Icons.check),
                              label: Text(
                                "ابدأ",
                                style: TextStyle(fontSize: 22),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      padding: EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          _showMyDialog(context);
                        },
                        child: Text(
                          "دخول الادمن",
                          style: TextStyle(
                              color: Color(0xffF4D6CC),
                              fontSize: 18,
                              shadows: [
                                Shadow(color: Colors.white, blurRadius: 1)
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    TextEditingController myController = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('الادمن'),
          content: TextField(
            decoration: InputDecoration(hintText: "رمز الدخول"),
            controller: myController,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('دخول'),
              onPressed: () {
                if (myController.text == "1234") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Admin()));
                } else {
                  Toast.show("الرمز غير صحيح", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

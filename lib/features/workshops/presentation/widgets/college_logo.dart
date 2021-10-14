import 'package:flutter/material.dart';

class CollegeLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(60),
            blurRadius: 6.0,
            spreadRadius: 10.0,
            offset: Offset(
              0.0,
              3.0,
            ),
          ),
        ],
      ),
      child: Image.asset("assets/college.png"),
    );
  }
}

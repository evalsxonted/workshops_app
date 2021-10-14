import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workshops/features/workshops/presentation/widgets/workshop-button.dart';
class ContactUS extends StatelessWidget {
  final String email;
  final int phone;
  const ContactUS({Key key, this.email, this.phone}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          myIcon: Icons.email,
          buttonText: "الايميل",
          buttonFunction: () {
            _launchURL(
              "mailto:" +
                  email +
                  "?subject=question&body=" +
                  "",
            );
          },
        ),
        MyCustomButton(
          myIcon: Icons.phone,
          buttonText: "الهاتف",
          buttonFunction: () {
            _launchURL(
              "tel:" + phone.toString(),
            );
          },
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

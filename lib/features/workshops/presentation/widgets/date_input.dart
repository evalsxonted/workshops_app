import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class MyDateInput extends StatelessWidget {
  final Function onDateSelected;
  final String buttonText;
  const MyDateInput({Key key, this.onDateSelected, this.buttonText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      // ignore: deprecated_member_use
      child: FlatButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2100, 1, 1), onChanged: (date) {
                }, onConfirm: onDateSelected, currentTime: DateTime.now(), locale: LocaleType.ar);
          },
          child: Text(
              buttonText,
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
    );
  }
}

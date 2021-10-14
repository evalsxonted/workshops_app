import 'package:flutter/material.dart';

class StartEndDates extends StatelessWidget {
  final String startDate;
  final String endDate;
  const StartEndDates({Key key, this.startDate, this.endDate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Wrap(children: [
        Text(
          "تاريخ الابتداء" +
              " " +
              startDate,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          "تاريخ الانتهاء" +
              " " +
              endDate,
          style: TextStyle(fontSize: 18),
        ),
      ],),
    );
  }
}

import 'package:flutter/material.dart';
class Fees extends StatelessWidget {
  final int fees;

  const Fees({Key key, this.fees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      child: Column(
        children: [
          Icon(fees == 0
              ? Icons.money_off
              : Icons.money),
          Text(
            fees == 0
                ? "مجانية"
                : fees.toString(),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Certificate extends StatelessWidget {
  final bool certificate;
  const Certificate({Key key, this.certificate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      child: Column(
        children: [
          Icon(certificate
              ? Icons.check
              : Icons.clear),
          Text("شهادة مشاركة", maxLines: 3),
        ],
      ),
    );
  }
}

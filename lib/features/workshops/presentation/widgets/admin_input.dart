import 'package:flutter/material.dart';
class AdminInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const AdminInput({Key key, this.hintText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        maxLines: 10,
        controller: controller,
        keyboardType: TextInputType.text,
      ),
    );
  }
}

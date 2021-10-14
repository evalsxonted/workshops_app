import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final IconData myIcon;
  final String buttonText;
  final Function buttonFunction;
  const MyCustomButton({Key key, this.myIcon, this.buttonText, this.buttonFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 48.0,
                    height: 48.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(myIcon))),
                Expanded(
                    child: Center(
                      child: Text(buttonText,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.black)),
                    )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () {
                  buttonFunction();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
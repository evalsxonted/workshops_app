import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  final String location;

  const LocationIcon({Key key, this.location}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      child: Column(
        children: [
          Icon(Icons.location_on),
          Text(location, maxLines: 3),
        ],
      ),
    );
  }
}

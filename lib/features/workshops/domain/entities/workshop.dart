
import 'package:workshops/core/error/failure.dart';

class Workshop{
  final String id;
  final String title;
  final String description;
  final String provider;
  final String image;
  final String location;
  final int fees;
  final bool certificate;
  final int phone;
  final String email;
  final String startDate;
  final String endDate;
  final bool available;
  final Failure failure;


  Workshop({this.id, this.title, this.description, this.provider, this.image,
      this.location, this.fees, this.certificate, this.phone,
      this.email, this.startDate, this.endDate, this.available, this.failure});

}

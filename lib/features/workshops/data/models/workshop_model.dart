import 'package:workshops/features/workshops/domain/entities/workshop.dart';

class WorkshopModel extends Workshop {
  WorkshopModel(
      {String id,
      String title,
      String description,
      String provider,
      String image,
      String location,
      int fees,
      bool certificate,
      int phone,
      String email,
      String startDate,
      String endDate,
      bool available,})
      : super(
            id: id,
            title: title,
            description: description,
            provider: provider,
            image: image,
            location: location,
            fees: fees,
            certificate: certificate,
            phone: phone,
            email: email,
            startDate: startDate,
            endDate: endDate,
            available: available,);

  factory WorkshopModel.fromMap(Map<String, dynamic> info) {

    return WorkshopModel(
      id: info["id"],
      title: info["title"],
      description: info["description"],
      provider: info["provider"],
      image: info["image"],
      location: info["location"],
      fees: (info["fees"] as num).toInt(),
      certificate: info["certificate"],
      phone: info["phone"],
      email: info["email"],
      startDate: info["startDate"],
      endDate: info["endDate"],
      available: info["available"] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "provider": provider,
      "image": image,
      "location": location,
      "fees": fees,
      "certificate": certificate,
      "phone": phone,
      "email": email,
      "startDate": startDate,
      "endDate": endDate,
      "available": available,
    };
  }
}

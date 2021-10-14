import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';

class MiniWorkshopsModel extends MiniWorkshops {
  final List<MiniWorkshopModel> workshops;

  MiniWorkshopsModel({bool available, this.workshops})
      : super(available: available, workshops: workshops);

  factory MiniWorkshopsModel.fromJsonMap(Map<String, dynamic> info){
    List miniWorkshopsList = info["workshops"];
    if(miniWorkshopsList.isEmpty){
      return MiniWorkshopsModel(
        available: false,
        workshops: [],
      );
    }else{
      return MiniWorkshopsModel(
        available: true,
        workshops: List.generate(miniWorkshopsList.length, (index) =>
            MiniWorkshopModel.fromJsonMap(miniWorkshopsList[index])),
      );
    }
  }

  factory MiniWorkshopsModel.fromFirestoreCollection(
      List<QueryDocumentSnapshot> documents){
    if (documents.isEmpty) {
      return MiniWorkshopsModel(
        available: false,
        workshops: [],
      );
    } else {
      List<Map<String, dynamic>> documentsData = List.generate(
        documents.length, (index) =>
      {
        ...{"id": documents[index].id},
        ...documents[index].data()
      },);
      return MiniWorkshopsModel(
        available: true,
        workshops: List.generate(documentsData.length, (index) =>
            MiniWorkshopModel.fromJsonMap(documentsData[index]),),
      );
    }
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "available": available,
      "workshops": List.generate(
          workshops.length, (index) => workshops[index].toJsonMap()),
    };
  }
}

class MiniWorkshopModel extends MiniWorkshop {
  MiniWorkshopModel({String id, String title, String image})
      : super(image: image, title: title, id: id);

  factory MiniWorkshopModel.fromJsonMap(Map workshopInfo){
    return MiniWorkshopModel(
      id: workshopInfo["id"],
      title: workshopInfo["title"],
      image: workshopInfo["image"],
    );
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": id,
      "title": title,
      "image": image,
    };
  }
}
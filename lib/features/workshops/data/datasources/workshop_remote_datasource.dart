import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workshops/core/error/exceptions.dart';
import 'package:workshops/features/workshops/data/models/mini_workshop_model.dart';
import 'package:workshops/features/workshops/data/models/workshop_model.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';

abstract class WorkshopRemoteDatasource{

  ///calls firebase to get specific workshop
  ///throw [ServerException] when failed
  Future<Workshop> getWorkshop(String id);
  Future<bool> setWorkshop(WorkshopModel workshopModel);
  Future<bool> deleteWorkshop(String workshopId);
}

class WorkshopRemoteDatasourceImplementation implements WorkshopRemoteDatasource{
  final FirebaseFirestore firebaseFirestore;
  WorkshopRemoteDatasourceImplementation({this.firebaseFirestore});

  @override
  Future<WorkshopModel> getWorkshop(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
      await firebaseFirestore.collection("workshops_full").doc(id).get();
      if(documentSnapshot.exists){
        return WorkshopModel.fromMap(documentSnapshot.data());
      }else{
        return WorkshopModel(available: false);
      }

    } on FirebaseException {
      throw ServerException();
    } catch (e) {
      throw ModelingException();
    }

  }

  @override
  Future<bool> setWorkshop(WorkshopModel workshopModel) async {
    try{
      await firebaseFirestore.collection("workshops_full").doc(workshopModel.id).set(workshopModel.toMap());
      await firebaseFirestore.collection("workshops_mini").doc(workshopModel.id).set(MiniWorkshopModel(
        id: workshopModel.id,
        title: workshopModel.title,
        image: workshopModel.image
      ).toJsonMap());
      return true;
    } on FirebaseException {
      throw ServerException();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteWorkshop(String workshopId) async {
    try{
      await firebaseFirestore.collection("workshops_full").doc(workshopId).delete();
      await firebaseFirestore.collection("workshops_mini").doc(workshopId).delete();
      return true;
    } on FirebaseException {
      throw ServerException();
    } catch (e) {
      throw Exception();
    }
  }

}
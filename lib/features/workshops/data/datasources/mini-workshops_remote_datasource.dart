import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workshops/core/error/exceptions.dart';
import 'package:workshops/features/workshops/data/models/mini_workshop_model.dart';

abstract class MiniWorkshopsRemoteDatasource {
  ///calls firebase to get specific workshop
  ///throw [ServerException] when failed
  Future<MiniWorkshopsModel> getMiniWorkshops();
}

class MiniWorkshopsRemoteDatasourceImplementation
    implements MiniWorkshopsRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  MiniWorkshopsRemoteDatasourceImplementation({this.firebaseFirestore});
  @override
  Future<MiniWorkshopsModel> getMiniWorkshops() async {
    try {
      QuerySnapshot querySnapshot =
              await firebaseFirestore.collection("workshops_mini").get();
      return MiniWorkshopsModel.fromFirestoreCollection(querySnapshot.docs);
    } on FirebaseException {
      throw ServerException();
    } catch (e) {
      throw ModelingException();
    }
  }
}

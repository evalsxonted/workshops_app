import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/exceptions.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/platform/network_info.dart';
import 'package:workshops/features/workshops/data/datasources/workshop_remote_datasource.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';
import 'package:workshops/features/workshops/domain/abstractions/workshop_abstractions.dart';

class WorkshopImplementation implements WorkshopAbstraction {
  final NetworkInfo networkInfo;
  final WorkshopRemoteDatasource workshopRemoteDatasource;

  WorkshopImplementation({
    this.networkInfo,
    this.workshopRemoteDatasource,
  });

  @override
  Future<Either<Failure, Workshop>> getWorkshop(String id) async {
    Either<Failure, Workshop> result = Either(null, null);
    if(await networkInfo.isConnected){
      try {
        Workshop remoteWorkshop = await workshopRemoteDatasource.getWorkshop(id);
        result.right = remoteWorkshop;
      } on ServerException {
        result.left = ServerFailure();
      } on ModelingException {
        result.left = ModelingFailure();
      }
    } else {
      result.right = Workshop(available: false);
      return result;
    }
    return result;
  }

  @override
  Future<bool> setWorkshop(Workshop workshop) async {
    return await workshopRemoteDatasource.setWorkshop(workshop);

  }

  @override
  Future<bool> deleteWorkshop(String workshopId) async {
    return await workshopRemoteDatasource.deleteWorkshop(workshopId);

  }
}

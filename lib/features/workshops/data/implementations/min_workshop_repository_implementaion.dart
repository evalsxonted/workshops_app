import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/exceptions.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/platform/network_info.dart';
import 'package:workshops/features/workshops/data/datasources/mini-workshops_remote_datasource.dart';
import 'package:workshops/features/workshops/data/datasources/mini_workshops_local_datasource.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';
import 'package:workshops/features/workshops/domain/abstractions/mini_workshops_abstraction.dart';

class MiniWorkshopsImplementation implements MiniWorkshopsAbstraction {
  final NetworkInfo networkInfo;
  final MiniWorkshopsLocalDatasource miniWorkshopsLocalDatasource;
  final MiniWorkshopsRemoteDatasource miniWorkshopsRemoteDatasource;

  MiniWorkshopsImplementation({
    this.networkInfo,
    this.miniWorkshopsLocalDatasource,
    this.miniWorkshopsRemoteDatasource,
  });

  @override
  Future<Either<Failure, MiniWorkshops>> getMiniWorkshops()async {
    Either<Failure, MiniWorkshops> result = Either(null, null);
    if(await networkInfo.isConnected){
      try {
        final MiniWorkshops remoteWorkshops = await miniWorkshopsRemoteDatasource.getMiniWorkshops();
        result.right = remoteWorkshops;
      } on ServerException {
        result.left = ServerFailure();
      } on ModelingException {
        result.left = ModelingFailure();
      }
    }else{
      try {
        final MiniWorkshops localWorkshops = await miniWorkshopsLocalDatasource.getCachedMiniWorkshops();
        result.right = localWorkshops;
      } on CacheException {
        result.left = CacheFailure();
      } on ModelingException {
        result.left = ModelingFailure();
      }
    }
    return result;
  }
}

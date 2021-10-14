import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast_io.dart';
import 'package:workshops/core/platform/network_info.dart';
import 'package:workshops/core/utilities/input_converter.dart';
import 'package:workshops/features/workshops/data/datasources/mini-workshops_remote_datasource.dart';
import 'package:workshops/features/workshops/data/datasources/mini_workshops_local_datasource.dart';
import 'package:workshops/features/workshops/data/datasources/workshop_remote_datasource.dart';
import 'package:workshops/features/workshops/data/implementations/min_workshop_repository_implementaion.dart';
import 'package:workshops/features/workshops/data/implementations/workshop_repository_implementaion.dart';
import 'package:workshops/features/workshops/domain/usecases/delete_workshop.dart';
import 'package:workshops/features/workshops/domain/usecases/get_mini_workshops.dart';
import 'package:workshops/features/workshops/domain/usecases/get_workshop.dart';
import 'features/workshops/domain/abstractions/mini_workshops_abstraction.dart';
import 'features/workshops/domain/abstractions/workshop_abstractions.dart';
import 'features/workshops/domain/usecases/set_workshop.dart';

final GetIt sl = GetIt.instance;

Future<void> setupGetIt() async {
  // sl.registerLazySingleton(() => WorkshopsPageController(
  //     workshopsNotifier: ValueNotifier(WorkshopsStates.loading),
  //     getMiniWorkshops: sl()));
  sl.registerLazySingleton(
    () => GetMiniWorkshops(
      miniWorkshopsAbstraction: sl(),
    ),
  );
  sl.registerLazySingleton<MiniWorkshopsAbstraction>(
    () => MiniWorkshopsImplementation(
      miniWorkshopsLocalDatasource: sl(),
      miniWorkshopsRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<MiniWorkshopsLocalDatasource>(
      () => MiniWorkshopsLocalDatasourceImplementation(sembastDB: sl()));
  sl.registerLazySingleton<MiniWorkshopsRemoteDatasource>(() =>
      MiniWorkshopsRemoteDatasourceImplementation(firebaseFirestore: sl()));
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementation(connectionChecker: sl()));
  Directory appDocDir = await getApplicationDocumentsDirectory();

  sembast.Database db = await databaseFactoryIo.openDatabase(appDocDir.path+ "/workshops.db");
  sl.registerLazySingleton<sembast.Database>(() => db //
      );
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => GetWorkshop(workshopAbstraction: sl()));
  sl.registerLazySingleton<WorkshopAbstraction>(() => WorkshopImplementation(
        networkInfo: sl(),
        workshopRemoteDatasource: sl(),//
      ));
  sl.registerLazySingleton<WorkshopRemoteDatasource>(() =>
      WorkshopRemoteDatasourceImplementation(firebaseFirestore: sl())
  );
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => SetWorkshop(
    workshopAbstraction: sl()
  ));
  sl.registerLazySingleton(() => DeleteWorkshop(
    workshopAbstraction: sl()
  ));

}

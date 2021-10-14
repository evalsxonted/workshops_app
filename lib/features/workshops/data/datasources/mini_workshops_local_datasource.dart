import 'package:sembast/sembast.dart';
import 'package:workshops/core/error/exceptions.dart';
import 'package:workshops/features/workshops/data/models/mini_workshop_model.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';

abstract class MiniWorkshopsLocalDatasource{
  ///calls firebase to get specific workshop
  ///throw [ServerException] when failed
  Future<MiniWorkshops> getCachedMiniWorkshops();
  Future<void> cacheMiniWorkshops(MiniWorkshopsModel miniWorkshopsModel);

}

class MiniWorkshopsLocalDatasourceImplementation implements MiniWorkshopsLocalDatasource{
  final Database sembastDB ;
  final StoreRef store = StoreRef.main();

  MiniWorkshopsLocalDatasourceImplementation({this.sembastDB});

  @override
  Future<MiniWorkshopsModel> getCachedMiniWorkshops()  async {
    Map cachedMiniWorkshopMap = await store.record('mini_workshops').get(sembastDB) as Map;
    if(cachedMiniWorkshopMap != null){
      return MiniWorkshopsModel.fromJsonMap(cachedMiniWorkshopMap);
    }else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMiniWorkshops(MiniWorkshopsModel miniWorkshopsModel) {
    return store.record('mini_workshops').put(sembastDB, miniWorkshopsModel.toJsonMap());
  }


}
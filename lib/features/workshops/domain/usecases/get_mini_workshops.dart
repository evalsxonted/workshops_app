import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';
import 'package:workshops/features/workshops/domain/abstractions/mini_workshops_abstraction.dart';

class GetMiniWorkshops implements UseCase<Either<Failure,MiniWorkshops>, NoParams>{
  final MiniWorkshopsAbstraction miniWorkshopsAbstraction;
  GetMiniWorkshops({this.miniWorkshopsAbstraction});

  @override
  Future<Either<Failure,MiniWorkshops>> call(NoParams noParams) async{
    Either<Failure,MiniWorkshops> result = Either(null, null);
    result = await miniWorkshopsAbstraction.getMiniWorkshops();
    return result;
  }
}



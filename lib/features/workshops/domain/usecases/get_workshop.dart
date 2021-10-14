import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';
import 'package:workshops/features/workshops/domain/abstractions/workshop_abstractions.dart';

class GetWorkshop implements UseCase<Either<Failure,Workshop>, String> {
  final WorkshopAbstraction workshopAbstraction;
  GetWorkshop({this.workshopAbstraction});

  @override
  Future<Either<Failure,Workshop>> call(String id)async{
    Either<Failure,Workshop> result = Either(null, null);
    result = await workshopAbstraction.getWorkshop(id);
     return result;
  }
}
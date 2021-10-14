import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';
import 'package:workshops/features/workshops/domain/abstractions/workshop_abstractions.dart';

class SetWorkshop implements UseCase<bool, Workshop> {
  final WorkshopAbstraction workshopAbstraction;
  SetWorkshop({this.workshopAbstraction});

  @override
  Future<bool> call(Workshop workshop)async{

    return  await workshopAbstraction.setWorkshop(workshop);

  }
}
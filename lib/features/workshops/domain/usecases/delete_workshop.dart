import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/features/workshops/domain/abstractions/workshop_abstractions.dart';

class DeleteWorkshop implements UseCase<bool, String> {
  final WorkshopAbstraction workshopAbstraction;
  DeleteWorkshop({this.workshopAbstraction});

  @override
  Future<bool> call(String workshopId)async{
    return await workshopAbstraction.deleteWorkshop(workshopId);
  }
}

import 'package:flutter/material.dart';
import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';
import 'package:workshops/features/workshops/domain/usecases/get_workshop.dart';
import 'package:workshops/features/workshops/presentation/states/workshop_states.dart';

class WorkshopPageController {
  final ValueNotifier<WorkshopStates> workshopsNotifier;
  final GetWorkshop getWorkshop;
  Workshop workshop;
  WorkshopPageController({this.getWorkshop, this.workshopsNotifier, String workshopId}) : assert (workshopId!=null){
    init(workshopId);
  }
  init(String workshopId) async {
    Either<Failure, Workshop> either = await getWorkshop(workshopId);

    if(either.isFailed){
      workshopsNotifier.value = WorkshopStates.error;
    }else{
      if(!either.right.available){
        workshopsNotifier.value = WorkshopStates.empty;
      }else{
        workshop = either.right;
        workshopsNotifier.value = WorkshopStates.loaded;
      }
    }
  }
}

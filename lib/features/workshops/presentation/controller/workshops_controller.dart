


import 'package:flutter/material.dart';
import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';
import 'package:workshops/features/workshops/domain/usecases/get_mini_workshops.dart';
import '../states/workshops_states.dart';

class WorkshopsPageController {
  final ValueNotifier<WorkshopsStates> workshopsNotifier;
  final GetMiniWorkshops getMiniWorkshops;
  List<MiniWorkshop> miniWorkshopList;
  WorkshopsPageController({this.getMiniWorkshops, this.workshopsNotifier}){
    init();
  }
  init() async {
    Either<Failure, MiniWorkshops> either = await getMiniWorkshops(NoParams());
    if(either.isFailed){
      workshopsNotifier.value = WorkshopsStates.error;
    }else{

      if(!either.right.available){
        workshopsNotifier.value = WorkshopsStates.empty;
      }else{
        miniWorkshopList = either.right.workshops;
        workshopsNotifier.value = WorkshopsStates.loaded;
      }
    }
  }
}


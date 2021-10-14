import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';

abstract class MiniWorkshopsAbstraction{
  Future<Either<Failure, MiniWorkshops>> getMiniWorkshops();
}
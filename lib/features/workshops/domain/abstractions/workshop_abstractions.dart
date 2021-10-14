import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';

abstract class WorkshopAbstraction{
  Future<Either<Failure, Workshop>> getWorkshop(String id);
  Future<bool> setWorkshop(Workshop workshop);
  Future<bool> deleteWorkshop(String workshopId);
}
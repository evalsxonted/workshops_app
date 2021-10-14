import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';

class InputConverter{
  Either<Failure, int> stringToUnsignedInteger(String str){
    Either<Failure, int> result;
      try {
        int num = int.parse(str);
        if(num < 0){
          result.left = InputConvertingFailure();
        }else{
          result.right = num;
        }
      } on FormatException {
        result.left = InputConvertingFailure();
      }catch (e){
        result.left = UnknownFailure();
      }
      return result;
  }
}
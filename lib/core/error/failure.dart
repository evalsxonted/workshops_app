
abstract class Failure {
  Failure([List properties = const <dynamic>[]]);
}

class ServerFailure implements Failure{}
class CacheFailure implements Failure{}
class ModelingFailure implements Failure{}
class InputConvertingFailure implements Failure{}
class UnknownFailure implements Failure{}
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

// General Failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
  //final String message;
  //ServerException(this.message);
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

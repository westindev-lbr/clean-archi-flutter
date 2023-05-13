import 'package:clean_archi_flutter_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class INumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint
  ///
  /// Throws a [serveurException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [serveurException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

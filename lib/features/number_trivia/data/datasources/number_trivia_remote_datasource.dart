import 'dart:convert';

import 'package:clean_archi_flutter_app/core/error/exceptions.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

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

class NumberTriviaRemoteDataSource implements INumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSource({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

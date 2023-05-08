import 'dart:convert';
import 'package:clean_archi_flutter_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(
      number: 14, text: 'Le 14 juillet, Fête nationale Française');

  test('should be a subclass of NumberTrivia entity', () async {
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson ', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      print(jsonMap);
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      print(result);
      // assert
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the JSON number is an double',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      print(jsonMap);
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      print(result);
      // assert
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      print('tNumberTriviaModel:  $tNumberTriviaModel');
      // act
      final result = tNumberTriviaModel.toJson();
      print("result: $result");
      // assert
      final expectedMap = {
        "text": "Le 14 juillet, Fête nationale Française",
        "number": 14,
      };

      expect(result, expectedMap);
    });
  });
}

import 'dart:convert';

import 'package:clean_archi_flutter_app/core/error/exceptions.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixtures_reader.dart';
import 'number_trivia_local_datasource_test.mocks.dart';

//@GenerateMocks([SharedPreferences])
@GenerateNiceMocks(
    [MockSpec<SharedPreferences>(onMissingStub: OnMissingStub.returnDefault)])
void main() {
  late NumberTriviaLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        NumberTriviaLocalDataSource(sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await dataSource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a cacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getLastNumberTrivia;

      expect(() => dataSource.getLastNumberTrivia(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTriva', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Supposée fin du monde', number: 2012);
    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}

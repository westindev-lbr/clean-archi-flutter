import 'package:bloc_test/bloc_test.dart';
import 'package:clean_archi_flutter_app/core/error/failures.dart';
import 'package:clean_archi_flutter_app/core/util/input_converter.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(EmptyState()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: "Test Bloc", number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    blocTest(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        build: () => bloc,
        setUp: () {
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => const Right(tNumberTrivia));
        },
        act: (bloc) {
          bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        },
        verify: (_) {
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
        });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Error] when the input is invalid',
      build: () => bloc,
      setUp: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
      expect: () => [const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    blocTest('should get data from the concrete use case',
        build: () => bloc,
        setUp: () {
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => const Right(tNumberTrivia));
        },
        act: (bloc) async {
          bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        },
        verify: (_) {
          verify(
              mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)));
        });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits [Loading, Loaded] when data is gotten successfully Bloc',
      build: () => bloc,
      setUp: () {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
      expect: () => [LoadingState(), const LoadedState(trivia: tNumberTrivia)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits [Loading, Error ] whith a proper message for the error when getting data fails',
      build: () => bloc,
      setUp: () {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
      expect: () =>
          [LoadingState(), const ErrorState(message: CACHE_FAILURE_MESSAGE)],
    );
  }); // Groupe Concrete

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(text: "Test Bloc", number: 1);

    blocTest('should get data from the random use case',
        build: () => bloc,
        setUp: () {
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => const Right(tNumberTrivia));
        },
        act: (bloc) async {
          bloc.add(GetTriviaForRandomNumber());
        },
        verify: (_) {
          verify(mockGetRandomNumberTrivia(NoParams()));
        });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits [Loading, Loaded] when data is gotten successfully Bloc',
      build: () => bloc,
      setUp: () {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(GetTriviaForRandomNumber());
      },
      expect: () => [LoadingState(), const LoadedState(trivia: tNumberTrivia)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits [Loading, Error ] whith a proper message for the error when getting data fails',
      build: () => bloc,
      setUp: () {
        // arrange

        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(GetTriviaForRandomNumber());
      },
      expect: () =>
          [LoadingState(), const ErrorState(message: CACHE_FAILURE_MESSAGE)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emits [Loading, Error ] whith a proper message for the error when getting server fails',
      build: () => bloc,
      setUp: () {
        // arrange

        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (NumberTriviaBloc bloc) {
        bloc.add(GetTriviaForRandomNumber());
      },
      expect: () =>
          [LoadingState(), const ErrorState(message: SERVER_FAILURE_MESSAGE)],
    );
  }); // Groupe Concrete
}

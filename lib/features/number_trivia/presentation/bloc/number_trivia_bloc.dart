import 'package:clean_archi_flutter_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaState get initialState => EmptyState();

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(EmptyState()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberStr);
      inputEither.fold((failure) {
        emit(const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE));
      }, (integer) async {
        emit(LoadingState());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        _eitherLoadedOrErrorState(failureOrTrivia, emit);
      });
    });

    on<GetTriviaForRandomNumber>(
      (event, emit) async {
        emit(LoadingState());
        final failureOrTrivia = await getRandomNumberTrivia(NoParams());
        _eitherLoadedOrErrorState(failureOrTrivia, emit);
      },
    );
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia>? failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    failureOrTrivia!.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (trivia) => emit(LoadedState(trivia: trivia)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}


/** 
 * Constructor ({ required params }) : super(Empty()) 
 * {
 *  on<Event>( (event , emit) {}); 
 *    un event et un emitter 
 *    
 *    si failure émet une Erreur
 *    si entier pas encore implémenté
 *    
 * */
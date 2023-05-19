part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class EmptyState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  const LoadedState({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class ErrorState extends NumberTriviaState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

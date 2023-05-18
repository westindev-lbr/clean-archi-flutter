part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberStr;

  const GetTriviaForConcreteNumber(this.numberStr);

  @override
  List<Object> get props => [numberStr];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}

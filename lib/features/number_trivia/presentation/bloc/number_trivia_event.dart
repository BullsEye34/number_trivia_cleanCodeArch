part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  late final String numberSting;
  GetTriviaForConcreteNumber(this.numberSting);

  @override
  List<Object> get props => [numberSting];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}

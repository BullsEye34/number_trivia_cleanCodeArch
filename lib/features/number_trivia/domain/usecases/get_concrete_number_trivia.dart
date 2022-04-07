import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

import 'package:numbertrivia/core/usecases/usecase.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>?>? call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable{
  final int number;
  Params({required this.number}) : super();

  @override
  // TODO: implement props
  List<Object?> get props => [number];
}
import 'package:numbertrivia/core/platform/network_information.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {
  late final NumberTriviaRemoteDatasource remoteDataSource;
  late final NumberTriviaLocalDatasource localDataSource;
  late final NetworkInformation networkInformation;
  NumberTriviaRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInformation});

  @override
  Future<Either<Failure, NumberTrivia>?>? getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    return null;
  }

  @override
  Future<Either<Failure, NumberTrivia>?>? getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    return null;
  }
}

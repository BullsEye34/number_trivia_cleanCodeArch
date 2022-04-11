import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/core/platform/network_information.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {
  late final NumberTriviaRemoteDatasource remoteDataSource;
  late final NumberTriviaLocalDatasource localDataSource;
  late final NetworkInformation networkInformation;
  NumberTriviaRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInformation});

  @override
  Future<Either<Failure, NumberTrivia>?>? getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number)!);
  }

  @override
  Future<Either<Failure, NumberTrivia>?>? getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia()!);
  }

  Future<Either<Failure, NumberTrivia>?>? _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInformation.isConnected!) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localtrivia = await localDataSource.getLastNumberTrivia()!;
        return Right(localtrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

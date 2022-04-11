import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/platform/network_information.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInformation {}

void main() {
  late NumberTriviaRepositoryImplementation repositoryImplementation;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImplementation = NumberTriviaRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInformation: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });
      body();
    });
  }

  group("Get conrete Number Trivia", () {
    const tnumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(
        text:
            "1e+21 is the number of grains of sand on all the world's beaches put together.",
        number: tnumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("Should check if device is online", () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockRemoteDataSource.getConcreteNumberTrivia(tnumber))
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      // act
      repositoryImplementation.getConcreteNumberTrivia(tnumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          "should return Remote Data when a call to remote datasource is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tnumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        // act
        final result =
            await repositoryImplementation.getConcreteNumberTrivia(tnumber);
        // assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tnumber));
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          "should return ServerFailure when a call to remote datasource is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tnumber))
            .thenThrow(ServerException());
        // act
        final result =
            await repositoryImplementation.getConcreteNumberTrivia(tnumber);
        // assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tnumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test("should retrun local cache data when cache data is present",
          () async {
        // ararnge
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        // act

        final result =
            await repositoryImplementation.getConcreteNumberTrivia(tnumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test("should throw CacheFailure when cache data is not present",
          () async {
        // ararnge
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        // act

        final result =
            await repositoryImplementation.getConcreteNumberTrivia(tnumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group("Get Random Number Trivia", () {
    final tNumberTriviaModel = NumberTriviaModel(
        text:
            "1e+21 is the number of grains of sand on all the world's beaches put together.",
        number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("Should check if device is online", () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      // act
      repositoryImplementation.getRandomNumberTrivia();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          "should return Remote Data when a call to remote datasource is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        // act
        final result = await repositoryImplementation.getRandomNumberTrivia();
        // assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          "should return ServerFailure when a call to remote datasource is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        // act
        final result = await repositoryImplementation.getRandomNumberTrivia();
        // assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test("should retrun local cache data when cache data is present",
          () async {
        // ararnge
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        // act

        final result = await repositoryImplementation.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test("should throw CacheFailure when cache data is not present",
          () async {
        // ararnge
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        // act

        final result = await repositoryImplementation.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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

  group("Get conrete Number Trivia", () {
    final tnumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(
        text:
            "1e+21 is the number of grains of sand on all the world's beaches put together.",
        number: tnumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    /* test("Should check if device is online", () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      // act
      await repositoryImplementation.getConcreteNumberTrivia(tnumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    }); */
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
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
          "should cache Remote Data locally when a call to remote datasource is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tnumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        // act
        await repositoryImplementation.getConcreteNumberTrivia(tnumber);
        // assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tnumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
    });
    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });
    });
  });
}

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
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
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
    final numberTriviaModel = NumberTriviaModel(
        text:
            "1e+21 is the number of grains of sand on all the world's beaches put together.",
        number: tnumber);
    final NumberTrivia tNumberTriviaModel = numberTriviaModel;
    test("Should check if device is online", () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      // act
      repositoryImplementation.getConcreteNumberTrivia(tnumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  });
}

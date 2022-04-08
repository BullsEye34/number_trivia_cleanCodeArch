import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/platform/network_information.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:numbertrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInformation {}

void main() {
  NumberTriviaRepositoryImplementation repositoryImplementation;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImplementation = NumberTriviaRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}

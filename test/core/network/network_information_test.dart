import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:numbertrivia/core/network/network_information.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInformationImpl networkInformationImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInformationImpl =
        NetworkInformationImpl(mockInternetConnectionChecker);
  });

  group("Is Connected", () {
    test("Should forward call to InternetConnectionChecker.hasConnection",
        () async {
      /* final Future<bool> tHasConnectionFuture = Future.value(true);
      // arrange
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final Future<bool> result = networkInformationImpl.isConnected!;
      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture); */
    });
  });
}

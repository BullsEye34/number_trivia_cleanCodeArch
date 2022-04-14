import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group("String to UnSigned Int", () {
    test("Should return integer when string represents unsigned integer",
        () async {
      // arrange
      final str = '123';
      // act
      final result = inputConverter.stringToUnignedInteger(str);
      // assert
      expect(result, Right(123));
    });

    test("Should return Failure when string is not an integer", () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.stringToUnignedInteger(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}

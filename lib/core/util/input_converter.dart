import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';

class InputConverter {
  Either<Failure, int>? stringToUnignedInteger(String str) {
    try {
      return Right(int.parse(str));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}

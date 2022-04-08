import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable with EquatableMixin {
  @override
  List<Object?> get props => [];
}

// failues
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

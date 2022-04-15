import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/util/input_converter.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  late final GetConcreteNumberTrivia getConcreteNumberTrivia;
  late final GetRandomNumberTrivia getRandomNumberTrivia;
  late final InputConverter inputConverter;
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      // TODO: implement event handler
      final inputEither =
          inputConverter.stringToUnignedInteger(event.numberSting);

      inputEither!.fold((l) {
        emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }, (integer) async* {
        emit(Loading());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        emit(failureOrTrivia!.fold(
            (l) => Error(message: _mapFailureToMessage(l)),
            (trivia) => Loaded(trivia: trivia)));
      });
    });
  }

  @override
  NumberTriviaState get initialState => Empty();

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

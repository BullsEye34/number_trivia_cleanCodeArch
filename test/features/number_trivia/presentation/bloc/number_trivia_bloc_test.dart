import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/util/input_converter.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late GetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late GetRandomNumberTrivia mockGetRandomNumberTrivia;
  late InputConverter mockInputConverter;
  late NumberTriviaBloc bloc;
  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group("Get Trivia For Concrete Number", () {
    late final tNumberString = "1";
    late final tNumberParsed = 1;
    late final tNumberTrivia = NumberTrivia(number: 1, text: "test trivia");

    void setUpMockConverterSuccess() =>
        when(mockInputConverter.stringToUnignedInteger(tNumberString))
            .thenReturn(Right(tNumberParsed));
    test(
        "should call InputConverter to validate and convert the string to an UnSigned integer",
        () async {
      // arrange
      setUpMockConverterSuccess();
      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          mockInputConverter.stringToUnignedInteger(tNumberString));
      // assert
      verify(mockInputConverter.stringToUnignedInteger(tNumberString));
    });

    test("should emit [ERROR] state when input is invalid", () async* {
      // arrange

      when(mockInputConverter.stringToUnignedInteger(tNumberString))
          .thenReturn(Left(InvalidInputFailure()));
      // assert Later
      var matchers = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(
        bloc,
        emitsInOrder(matchers),
      );

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test("should give data for the concrete useCase", () async* {
      // arrange

      setUpMockConverterSuccess();
      when(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)))
          .thenAnswer((_) async => Right(tNumberTrivia));

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      // assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test(
        "Should emit Empty, Loading and Loaded when data is fetched successfully",
        () async* {
      // arrange

      setUpMockConverterSuccess();
      when(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
      expectLater(bloc.state, expected);
      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
}

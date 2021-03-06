import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/usecases/usecase.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {

}

void main(){
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository =  MockNumberTriviaRepository();
    usecase =  GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia =  NumberTrivia(text: "Test", number: 1);
  test('Should Get Random Trivia from Trivia Repository', ()async{
    // arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((realInvocation)async => Right(tNumberTrivia));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
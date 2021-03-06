import 'package:dartz/dartz.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {

}

void main(){
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository =  MockNumberTriviaRepository();
    usecase =  GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber=1;
  final tNumberTrivia =  NumberTrivia(text: "Test", number: tNumber);
  test('Should Get Trivia for the number from Trivia Repository', ()async{
    // arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)).thenAnswer((realInvocation)async => Right(tNumberTrivia));
    // act
    final result = await usecase(Params(number: tNumber));
    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
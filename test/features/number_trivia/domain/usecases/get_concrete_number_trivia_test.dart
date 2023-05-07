import 'package:clean_archi_flutter_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/repositories/number_trivia_repository_interface.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements INumberTriviaRepository {}

@GenerateMocks([INumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late int tNumber;
  late NumberTrivia tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    tNumber = 1;
    tNumberTrivia =
        const NumberTrivia(text: 'Naissance de Calum', number: 2012);
  });

  test('Should get trivia for the number from the repository', () async {
    // arrange (on veut que quand on passe tNumber en param qu'on retourne notre tNumberTrivia)
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // act (On applique simplement notre usecase avec un paramètre au choix)
    final result = await usecase.execute(number: tNumber);
    // assert (on vérifie si c'est le bon résultat attendu)
    expect(result, Right(tNumberTrivia));
    // ici on vérifie si la méthode a été appelée avec le bon paramètre
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

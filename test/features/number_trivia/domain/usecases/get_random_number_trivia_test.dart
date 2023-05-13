import 'package:clean_archi_flutter_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/repositories/number_trivia_repository_interface.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([INumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late MockINumberTriviaRepository mockNumberTriviaRepository;
  late NumberTrivia tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockINumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
    tNumberTrivia =
        const NumberTrivia(text: 'Naissance de Calum', number: 2012);
  });

  test('Should get trivia from the repository', () async {
    // arrange (on veut que quand on passe tNumber en param qu'on retourne notre tNumberTrivia)
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));
    // act (On applique simplement notre usecase avec un paramètre au choix)
    final result = await usecase(NoParams());
    // assert (on vérifie si c'est le bon résultat attendu)
    expect(result, Right(tNumberTrivia));
    // ici on vérifie si la méthode a été appelée avec le bon paramètre
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

import 'package:clean_archi_flutter_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/repositories/number_trivia_repository_interface.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetConcreteNumberTrivia {
  final INumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>?> execute({required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}

import 'package:clean_archi_flutter_app/core/platform/network_info.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements INumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements INumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  NumberTriviaRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepository(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
}

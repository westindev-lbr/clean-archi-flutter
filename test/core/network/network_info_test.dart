// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:clean_archi_flutter_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfo networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfo(mockInternetConnectionChecker);
  });

  group('isConnected =>', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final result = networkInfo.isConnected;
      print(mockInternetConnectionChecker);
      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}

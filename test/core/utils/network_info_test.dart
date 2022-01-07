import 'package:flutter_test/flutter_test.dart';
import 'package:franks_invoice_tool/core/util/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfo networkInfo;
  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });
  test(
      '[NetworkInfoImpl] should forwared the call to the InternetConnectionCheckerPackage',
      () async {
    // Arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) async => true);
    // Act
    await networkInfo.isConnected;
    // Assert
    verify(mockInternetConnectionChecker.hasConnection);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:pulsex/src/services/auth_service.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('AuthService', () {
    test('sign in with Google returns auth state', () async {
      // TODO: Add proper unit tests for auth service
    });
  });
}
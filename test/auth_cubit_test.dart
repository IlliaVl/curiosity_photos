import 'package:bloc_test/bloc_test.dart';
import 'package:curiosity_photos/domain/abstracts/repositories/auth_repository_interface.dart';
import 'package:curiosity_photos/domain/cubits/auth/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthRepository extends Mock implements AuthRepositoryInterface {}

void main() {
  final repository = FirebaseAuthRepository();

  late AuthCubit cubit;

  setUp(
    () {
      cubit = AuthCubit(repository: repository);

      when(
        repository.anonymousAuth,
      ).thenAnswer(
        (_) async {},
      );
    },
  );

  blocTest<AuthCubit, AuthState>(
    'Starts with empty state',
    build: () => cubit,
    verify: (c) => expect(
      c.state,
      AuthInitial(),
    ),
  );

  blocTest<AuthCubit, AuthState>(
    'Logs in anonymously',
    build: () => cubit,
    act: (c) => c.anonymousAuth(),
    expect: () => [
      AuthLoggingIn(),
      AuthLoggedIn(),
    ],
    verify: (c) {
      verify(
        repository.anonymousAuth,
      ).called(1);
    },
  );

  blocTest<AuthCubit, AuthState>(
    'Handles exceptions gracefully',
    setUp: () {
      when(
        repository.anonymousAuth,
      ).thenAnswer(
        (_) async => throw Exception('Some Error'),
      );
    },
    build: () => cubit,
    act: (c) => c.anonymousAuth(),
    expect: () => [
      AuthLoggingIn(),
      AuthErrorGeneric(),
    ],
    verify: (c) {
      verify(
        repository.anonymousAuth,
      ).called(1);
    },
  );
}

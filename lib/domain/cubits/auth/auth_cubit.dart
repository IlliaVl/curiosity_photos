import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../abstracts/repositories/auth_repository_interface.dart';
import '../../exceptions/curiosity_exception.dart';

part 'auth_state.dart';

/// A cubit that is responsible for auth methods.
class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryInterface _repository;

  AuthCubit({
    required AuthRepositoryInterface repository,
  })  : _repository = repository,
        super(AuthInitial());

  Future<void> anonymousAuth() async {
    emit(AuthLoggingIn());

    try {
      await _repository.anonymousAuth();
      emit(AuthLoggedIn());
    } on CuriosityException catch (e) {
      switch (e.errorType) {
        case CuriosityExceptionType.network:
          emit(AuthErrorNetwork());
        default:
          emit(AuthErrorGeneric());
      }
    } on Exception catch (_) {
      emit(AuthErrorGeneric());
    }
  }
}

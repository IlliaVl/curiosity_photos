part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoggingIn extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoggedIn extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorGeneric extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorNetwork extends AuthState {
  @override
  List<Object?> get props => [];
}

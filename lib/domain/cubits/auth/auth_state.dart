part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoggingIn extends AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthErrorGeneric extends AuthState {}

class AuthErrorNetwork extends AuthState {}

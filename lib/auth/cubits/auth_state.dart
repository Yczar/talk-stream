part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({
    required this.user,
  });
  final User user;
}

class AuthUnAuthenticated extends AuthState {}

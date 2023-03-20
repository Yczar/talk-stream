// ignore_for_file: public_member_api_docs
part of 'signin_cubit.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninLoaded extends SigninState {
  SigninLoaded({
    required this.user,
  });
  final User user;
}

class SigninError extends SigninState {
  SigninError({
    required this.errorMessage,
  });
  final String errorMessage;
}

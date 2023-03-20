import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:talk_stream/auth/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void authenticateUser(User user) => emit(AuthAuthenticated(user: user));
  void unAuthenticateUser(User user) => emit(AuthUnAuthenticated());
}

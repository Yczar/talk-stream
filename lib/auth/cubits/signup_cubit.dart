import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/src/http_service.dart';
import 'package:talk_stream/app/src/constants/server_constants.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/auth/models/user.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  Future<void> signup(
    User params,
    AuthCubit authCubit,
  ) async {
    emit(SignupLoading());
    final httpService = locator<HttpService>();
    try {
      final result = await httpService.post(
        '/auth/signup',
        body: params.toJson(),
        headers: {
          ...serverHeaders,
        },
      );
      authCubit.authenticateUser(
        User.fromJson(
          jsonDecode(result.body) as Map<String, dynamic>,
        ),
      );
      print(result);
    } on HttpException catch (e) {
      print(e.message);

      emit(
        SignupError(
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        SignupError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/src/http_service.dart';
import 'package:talk_stream/app/src/constants/server_constants.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/auth/models/user.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());
  Future<void> signin(
    User params,
    AuthCubit authCubit,
  ) async {
    emit(SigninLoading());
    final httpService = locator<HttpService>();
    try {
      final result = await httpService.post(
        '/auth/signin',
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
      // emit(
      //   SigninLoaded(
      //     user: ,
      //   ),
      // );
    } on HttpException catch (e) {
      emit(
        SigninError(
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        SigninError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

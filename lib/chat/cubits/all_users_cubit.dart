import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/src/http_service.dart';
import 'package:talk_stream/app/src/constants/server_constants.dart';
import 'package:talk_stream/auth/models/user.dart';

part 'all_users_state.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit() : super(AllUsersInitial());

  Future<void> fetchAllUsers(String userId) async {
    emit(AllUsersLoading());
    final httpService = locator<HttpService>();
    try {
      final result = await httpService.get(
        '/auth/getusers',
        headers: {
          ...serverHeaders,
          'userId': userId,
        },
      );
      emit(
        AllUsersLoaded(
          users: (jsonDecode(result.body) as List)
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
    } on HttpException catch (erorr) {
      emit(
        AllUsersError(
          errorMessage: erorr.message,
        ),
      );
    } catch (erorr) {
      emit(
        AllUsersError(
          errorMessage: erorr.toString(),
        ),
      );
    }
  }
}

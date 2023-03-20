import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/src/http_service.dart';
import 'package:talk_stream/app/src/constants/server_constants.dart';
import 'package:talk_stream/chat/models/chat.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  Future<void> fetchRecentChats(
    String userId, {
    bool reload = true,
  }) async {
    if (reload) {
      emit(ChatLoading());
    }
    final httpService = locator<HttpService>();
    try {
      final result = await httpService.get(
        '/chat/get_chats',
        headers: {
          ...serverHeaders,
          'userId': userId,
        },
      );
      print(result.body);
      if (!reload) {
        emit(ChatInitial());
      }
      emit(
        ChatLoaded(
          chats: (jsonDecode(result.body) as List).map((e) {
            return Chat.fromJson(e as Map<String, dynamic>);
          }).toList(),
        ),
      );
    } on HttpException catch (e) {
      print(e.message);
      emit(
        ChatError(
          errorMessage: e.message,
        ),
      );
    } catch (e, s) {
      print(e);
      print(s);
      emit(
        ChatError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

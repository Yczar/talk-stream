import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:talk_stream/app/core/services/services.dart';

import 'package:talk_stream/chat/models/models.dart';

part 'chat_socket_state.dart';

class ChatSocketCubit extends Cubit<ChatSocketState> {
  ChatSocketCubit({
    required WebSocketService webSocketService,
    required this.userId,
  })  : _webSocketService = webSocketService,
        super(ChatSocketInitial()) {
    _socketSubscription = webSocketService.stream.listen((event) {
      newMessage(
        Message.fromJson(
          jsonDecode(event as String) as Map<String, dynamic>,
        ),
      );
    });
  }
  late final StreamSubscription<dynamic> _socketSubscription;
  final WebSocketService _webSocketService;
  final String userId;

  void newMessage(Message message) {
    emit(ChatSocketInitial());
    if (message.members!.contains(userId)) {
      emit(
        ChatSocketUpdated(
          message: message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _webSocketService.dispose();
    _socketSubscription.cancel();
    return super.close();
  }
}

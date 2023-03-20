import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talk_stream/app/core/services/services.dart';

import 'package:talk_stream/chat/models/message.dart';

part 'chat_details_socket_state.dart';

class ChatDetailsSocketCubit extends Cubit<ChatDetailsSocketState> {
  ChatDetailsSocketCubit({
    required WebSocketService webSocketService,
    required String userId,
    required String roomId,
  })  : _webSocketService = webSocketService,
        _userId = userId,
        _roomId = roomId,
        super(ChatDetailsSocketInitial()) {
    _socketSubscription = webSocketService.stream.listen((event) {
      addMessage(
        Message.fromJson(
          jsonDecode(event as String) as Map<String, dynamic>,
        ),
      );
    });
  }
  late final StreamSubscription<dynamic> _socketSubscription;
  final WebSocketService _webSocketService;
  final String _userId;
  final String _roomId;

  void sendMessage(String message) {
    _webSocketService.send(
      Message(
        message: message,
        sender: _userId,
        members: [_userId, _roomId],
        timestamp: DateTime.now(),
      ).toJson(),
    );
  }

  void addMessage(Message message) {
    if (message.members!.contains(_userId)) {
      emit(
        NewMessageReceived(
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

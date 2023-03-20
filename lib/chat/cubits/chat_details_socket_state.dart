part of 'chat_details_socket_cubit.dart';

abstract class ChatDetailsSocketState extends Equatable {}

class ChatDetailsSocketInitial extends ChatDetailsSocketState {
  @override
  List<Object?> get props => [];
}

class NewMessageReceived extends ChatDetailsSocketState {
  NewMessageReceived({
    required this.message,
  });
  final Message message;

  @override
  List<Object?> get props => [message];
}

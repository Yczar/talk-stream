// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_socket_cubit.dart';

abstract class ChatSocketState extends Equatable {
  const ChatSocketState();

  @override
  List<Object> get props => [];
}

class ChatSocketInitial extends ChatSocketState {}

class ChatSocketUpdated extends ChatSocketState {
  const ChatSocketUpdated({
    required this.message,
  });
  final Message message;
}

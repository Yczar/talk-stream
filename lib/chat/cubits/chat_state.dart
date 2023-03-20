// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  const ChatLoaded({
    required this.chats,
  });
  final List<Chat> chats;
}

class ChatError extends ChatState {
  const ChatError({
    required this.errorMessage,
  });
  final String errorMessage;
}

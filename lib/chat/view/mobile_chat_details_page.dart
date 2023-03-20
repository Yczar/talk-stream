import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/services.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/auth/models/user.dart';
import 'package:talk_stream/chat/cubits/chat_details_socket_cubit.dart';
import 'package:talk_stream/chat/models/message.dart';
import 'package:talk_stream/chat/view/widgets/bottom_chat_field.dart';
import 'package:talk_stream/chat/view/widgets/chat_bubble.dart';

class MobileChatDetailsPage extends StatefulWidget {
  const MobileChatDetailsPage({
    required this.user,
    required this.messages,
    super.key,
  });
  final User? user;
  final List<Message> messages;

  @override
  State<MobileChatDetailsPage> createState() => _MobileChatDetailsPageState();
}

class _MobileChatDetailsPageState extends State<MobileChatDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return BlocProvider(
            create: (context) => ChatDetailsSocketCubit(
              roomId: widget.messages.firstOrNull?.roomId ?? '',
              userId: state.user.id ?? '',
              webSocketService: WebSocketService(),
            ),
            child: MobileChatDetailsView(
              user: widget.user,
              me: state.user,
              messages: widget.messages,
            ),
          );
        }
        return const Offstage();
      },
    );
  }
}

class MobileChatDetailsView extends StatefulWidget {
  const MobileChatDetailsView({
    required this.messages,
    super.key,
    this.user,
    this.me,
  });

  final User? user;
  final User? me;
  final List<Message> messages;

  @override
  State<MobileChatDetailsView> createState() => _MobileChatDetailsViewState();
}

class _MobileChatDetailsViewState extends State<MobileChatDetailsView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatDetailsSocketCubit, ChatDetailsSocketState>(
      listener: (context, state) {
        if (state is NewMessageReceived) {
          widget.messages.add(state.message);
          _listKey.currentState?.insertItem(widget.messages.length - 1);
          Future.delayed(const Duration(milliseconds: 300), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: MemoryImage(
                  Uint8List.fromList(
                    widget.user!.profileImage!.codeUnits,
                  ),
                ),
              ),
              const XMargin(20),
              Column(
                children: [
                  Text(
                    (widget.user?.name ?? '').toLowerCase(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                initialItemCount: widget.messages.length,
                itemBuilder: (context, index, animation) {
                  final message = widget.messages[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ChatBubble(
                      message: message.message ?? '',
                      isMe: message.sender == widget.me?.id,
                    ),
                  );
                },
              ),
            ),
            BottomChatField(
              onSend: (message) {
                locator<WebSocketService>().send(
                  Message(
                    message: message,
                    sender: widget.me?.id,
                    members: <String>[
                      widget.me?.id ?? '',
                      widget.user?.id ?? ''
                    ],
                    timestamp: DateTime.now(),
                  ).toJson(),
                );
              },
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }
}

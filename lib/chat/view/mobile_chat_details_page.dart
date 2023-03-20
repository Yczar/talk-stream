import 'package:collection/collection.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
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

class MobileChatDetailsPage extends StatefulWidget {
  const MobileChatDetailsPage({
    super.key,
    required this.user,
    required this.messages,
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
              messages: widget.messages,
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
    super.key,
    this.user,
    this.me,
    required this.messages,
  });

  final User? user;
  final User? me;
  final List<Message> messages;

  @override
  _MobileChatDetailsViewState createState() => _MobileChatDetailsViewState();
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

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft:
                isMe ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
    required this.onSend,
  });
  final Function(String) onSend;

  @override
  _BottomChatFieldState createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isComposing = false;
  bool _showingEmojis = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            _showingEmojis
                                ? Icons.close
                                : Icons.insert_emoticon,
                          ),
                          onPressed: () {
                            _showingEmojis = !_showingEmojis;
                            setState(() {});
                            // Implement emoji picker or open keyboard
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            maxLines: null,
                            onChanged: (String text) {
                              setState(() {
                                _isComposing = text.isNotEmpty;
                              });
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Type a message',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            // Implement file picker or open camera/gallery
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _isComposing
                              ? () {
                                  widget.onSend(_textEditingController.text);
                                  _textEditingController.clear();
                                  setState(() {
                                    _isComposing = false;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showingEmojis)
              SizedBox(
                height: 300,
                width: double.infinity,
                child: EmojiPicker(
                  onEmojiSelected: (emoji, category) {
                    setState(() {
                      _textEditingController.text =
                          _textEditingController.text + category.emoji;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

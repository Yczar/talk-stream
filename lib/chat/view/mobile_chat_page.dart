import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';
import 'package:talk_stream/app/core/services/services.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/chat/cubits/chat_cubit.dart';
import 'package:talk_stream/chat/cubits/chat_socket_cubit.dart';
import 'package:talk_stream/chat/view/widgets/chat_item_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class MobileChatPage extends StatelessWidget {
  MobileChatPage({
    super.key,
  });
  final _webSocketService = WebSocketService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return Nested(
            children: [
              BlocProvider(
                create: (_) => ChatSocketCubit(
                  webSocketService: _webSocketService,
                  userId: state.user.id ?? '',
                ),
              ),
              BlocProvider(
                create: (context) =>
                    ChatCubit()..fetchRecentChats(state.user.id ?? ''),
                lazy: false,
              ),
            ],
            child: MobileChatView(userId: state.user.id!),
          );
        }
        return const Offstage();
      },
    );
  }
}

class MobileChatView extends StatelessWidget {
  const MobileChatView({
    required this.userId,
    super.key,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: [
        BlocListener<ChatSocketCubit, ChatSocketState>(
          listener: (_, chatState) {
            if (chatState is ChatSocketUpdated) {
              context.read<ChatCubit>().fetchRecentChats(
                    userId,
                    reload: false,
                  );
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            FontAwesomeIcons.user,
            size: 18,
          ),
          title: const Text(
            'Recent chats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                const YMargin(16),
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoaded) {
                        return ListView.separated(
                          itemBuilder: (_, index) {
                            final chat = state.chats[index];
                            return ChatItemWidget(
                              title: chat.user?.name,
                              onTap: () {
                                context.push(
                                  AppRoutes.mobileChatDetails,
                                  extra: {
                                    'user': chat.user,
                                    'messages': chat.messages,
                                  },
                                );
                              },
                              description: chat.lastMessage,
                              time: timeago
                                  .format(chat.timeStamp ?? DateTime.now()),
                              profileImage: MemoryImage(
                                Uint8List.fromList(
                                  chat.user!.profileImage!.codeUnits,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const YMargin(20),
                          itemCount: state.chats.length,
                        );
                      } else if (state is ChatLoading) {
                        return const Center(
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xFF1F1F1F)),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      } else if (state is ChatError) {
                        return Text(state.errorMessage);
                      }
                      return const Offstage();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF121212),
          onPressed: () {
            context.push(AppRoutes.mobileAllUsers);
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

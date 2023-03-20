import 'package:flutter/material.dart';
import 'package:talk_stream/app/view/widgets/responsive_view.dart';
import 'package:talk_stream/chat/view/mobile_chat_page.dart';
import 'package:talk_stream/chat/view/web_chat_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatView();
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobileView: MobileChatPage(),
      webView: const WebChatPage(),
    );
  }
}

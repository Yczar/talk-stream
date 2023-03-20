import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/auth/models/user.dart';
import 'package:talk_stream/auth/view/mobile_sign_in_page.dart';
import 'package:talk_stream/auth/view/mobile_sign_uo_page.dart';
import 'package:talk_stream/auth/view/web_auth_page.dart';
import 'package:talk_stream/chat/models/message.dart';
import 'package:talk_stream/chat/view/chat_page.dart';
import 'package:talk_stream/chat/view/mobile_all_users_page.dart';
import 'package:talk_stream/chat/view/mobile_chat_details_page.dart';
import 'package:talk_stream/counter/counter.dart';
import 'package:talk_stream/splash/view/splash_page.dart';

class GoRouterService {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.counter,
        builder: (context, state) => const CounterPage(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => const ChatPage(),
      ),
      GoRoute(
        path: AppRoutes.webAuth,
        builder: (context, state) => const WebAuthPage(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const MobileSignInPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const MobileSignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.mobileAllUsers,
        builder: (context, state) => const MobileAllUsersPage(),
      ),
      GoRoute(
        path: AppRoutes.mobileChatDetails,
        builder: (context, state) => MobileChatDetailsPage(
          user: (state.extra as Map?)?['user'] as User?,
          messages: (state.extra as Map?)?['messages'] as List<Message>? ?? [],
        ),
      ),
    ],
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: const Center(
        child: Text('404 - Page Not Found'),
      ),
    );
  }
}

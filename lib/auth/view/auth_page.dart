import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_stream/app/view/widgets/responsive_view.dart';
import 'package:talk_stream/auth/view/web_auth_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView();
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobileView: Scaffold(
        body: const Center(child: Text('HELL')),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
      webView: const WebAuthPage(),
    );
  }
}

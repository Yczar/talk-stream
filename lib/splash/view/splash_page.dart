import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/app/src/extensions/context_extensions.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..splashDelay(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            if (context.isLargeScreen) {
              context.go(AppRoutes.webAuth);
            } else {
              context.go(AppRoutes.signIn);
            }
          }
        },
        child: const SplashView(),
      ),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.mic_external_on_sharp,
            ),
            XMargin(10),
            Text(
              'TalkStream',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

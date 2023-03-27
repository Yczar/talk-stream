import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/app/src/constants/string_constant.dart';
import 'package:talk_stream/app/src/extensions/context_extensions.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/cubits/signin_cubit.dart';
import 'package:talk_stream/auth/view/widgets/web_sign_in_widget.dart';

class MobileSignInPage extends StatefulWidget {
  const MobileSignInPage({super.key});

  @override
  State<MobileSignInPage> createState() => _MobileSignInPageState();
}

class _MobileSignInPageState extends State<MobileSignInPage> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: [
        BlocProvider<SigninCubit>(
          create: (_) => SigninCubit(),
        ),
        BlocListener<SigninCubit, SigninState>(
          listener: (_, state) {
            if (state is SigninError) {
              context.showInAppNotifications(
                state.errorMessage,
              );
            } else if (state is SigninLoaded) {
              context.go(AppRoutes.chat);
            }
          },
        )
      ],
      child: _MobileSignInView(
        emailController: _emailEditingController,
        passwordController: _passwordEditingController,
      ),
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}

class _MobileSignInView extends StatelessWidget {
  const _MobileSignInView({
    required this.passwordController,
    required this.emailController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(30),
              Row(
                children: const [
                  Icon(
                    Icons.mic_external_on_sharp,
                  ),
                  XMargin(10),
                  Text(
                    AppString.talkStream,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const YMargin(20),
              const Text(
               AppString.signIn,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const YMargin(6),
              const Text(
                AppString.talkStreamDescription,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const YMargin(40),
              SignInView(
                onSwitch: () {
                  context.go(AppRoutes.signUp);
                },
                emailEditingController: emailController,
                passwordEditingController: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

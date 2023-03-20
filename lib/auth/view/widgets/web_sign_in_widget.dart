// **Web Version**
// *Still In Progres**
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_stream/app/src/extensions/context_extensions.dart';
import 'package:talk_stream/app/view/widgets/custom_text_field.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/auth.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';

class WebSignInWidget extends StatefulWidget {
  const WebSignInWidget({
    super.key,
    required this.onSwitch,
  });
  final VoidCallback onSwitch;

  @override
  State<WebSignInWidget> createState() => _WebSignInWidgetState();
}

class _WebSignInWidgetState extends State<WebSignInWidget> {
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
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: BlocListener<SigninCubit, SigninState>(
        listener: (context, state) async {
          if (state is SigninError) {
            context.showInAppNotifications(
              state.errorMessage,
            );
          } else if (state is SigninLoaded) {
            // context.read<UserProvider>().updateUser(state.user);
            // await Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (_) => const ChatPage(),
            //   ),
            // );
          }
        },
        child: Builder(
          builder: (context) {
            // context.read<SigninCubit>().signin(
            //       SignInParams(
            //         email: _emailEditingController.text,
            //         password: _passwordEditingController.text,
            //       ),
            //     );
            return SignInView(
              onSwitch: widget.onSwitch,
              emailEditingController: _emailEditingController,
              passwordEditingController: _passwordEditingController,
            );
          },
        ),
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

class SignInView extends StatelessWidget {
  const SignInView({
    super.key,
    required this.onSwitch,
    required this.emailEditingController,
    required this.passwordEditingController,
  });
  final VoidCallback onSwitch;
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return IntrinsicHeight(
      child: Column(
        children: [
          CustomTextField(
            label: 'Email',
            icon: FontAwesomeIcons.envelope,
            hintText: 'Enter your email',
            controller: emailEditingController,
          ),
          const YMargin(24),
          CustomTextField(
            label: 'Password',
            icon: FontAwesomeIcons.lock,
            hintText: 'Enter your password',
            controller: passwordEditingController,
            obscureText: true,
          ),
          const SizedBox(height: 44),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: BlocBuilder<SigninCubit, SigninState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF121212),
                  ),
                  onPressed: () {
                    context.read<SigninCubit>().signin(
                          User(
                            email: emailEditingController.text,
                            password: passwordEditingController.text,
                          ),
                          authCubit,
                        );
                    // if (_formKey.currentState!.validate()) {
                    //   // submit the form
                    // }
                  },
                  child: state is SigninLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                );
              },
            ),
          ),
          const YMargin(24),
          Center(
            child: TextButton(
              onPressed: onSwitch,
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xFF121212),
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up here.',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xFF121212),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

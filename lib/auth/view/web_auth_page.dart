// **Web Version**
// *Still In Progres**
import 'package:flutter/material.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/view/widgets/web_sign_in_widget.dart';
import 'package:talk_stream/auth/view/widgets/web_sign_up_widget.dart';

class WebAuthPage extends StatefulWidget {
  const WebAuthPage({super.key});

  @override
  State<WebAuthPage> createState() => _WebAuthPageState();
}

enum _PageEnum {
  signin,
  signup,
}

class _WebAuthPageState extends State<WebAuthPage> {
  late ValueNotifier<_PageEnum> _currentPageNotfier;

  @override
  void initState() {
    super.initState();
    // context.read<HomeCubit>().fetchUsers('s');
    _currentPageNotfier = ValueNotifier(_PageEnum.signup);
  }

  @override
  Widget build(BuildContext context) {
    return _HomeView(
      currentPageNotifier: _currentPageNotfier,
    );
  }

  @override
  void dispose() {
    _currentPageNotfier.dispose();
    super.dispose();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    required this.currentPageNotifier,
  });
  final ValueNotifier<_PageEnum> currentPageNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                  // horizontal: 124,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    const YMargin(44),
                    ValueListenableBuilder(
                      valueListenable: currentPageNotifier,
                      builder: (context, currentPage, __) {
                        return Text(
                          currentPage != _PageEnum.signin
                              ? 'Sign In'
                              : 'Create an account.',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        );
                      },
                    ),
                    const YMargin(6),
                    const Text(
                      'TalkStream is a versatile chat app that offers a '
                      'seamless messaging experience for both personal and '
                      'professional use. It was built using Dart Frog and Flutter.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const YMargin(44),
                    Divider(
                      height: 1,
                      color: const Color(0xFF55565A).withOpacity(0.12),
                    ),
                    const YMargin(44),
                    ValueListenableBuilder<_PageEnum>(
                      valueListenable: currentPageNotifier,
                      builder: (context, currentPage, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: currentPage == _PageEnum.signin
                              ? WebSignUpWidget(
                                  onSwitch: () {
                                    currentPageNotifier.value =
                                        _PageEnum.signup;
                                  },
                                )
                              : WebSignInWidget(
                                  onSwitch: () => currentPageNotifier.value =
                                      _PageEnum.signin,
                                ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: const Color(0xFFFFFDF9),
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }
}

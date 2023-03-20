import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nested/nested.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/app/src/extensions/context_extensions.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/cubits/signup_cubit.dart';
import 'package:talk_stream/auth/view/widgets/web_sign_up_widget.dart';

class MobileSignUpPage extends StatefulWidget {
  const MobileSignUpPage({super.key});

  @override
  State<MobileSignUpPage> createState() => _MobileSignUpPageState();
}

class _MobileSignUpPageState extends State<MobileSignUpPage> {
  late TextEditingController _nameController;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  final ImagePicker _picker = ImagePicker();

  Uint8List? _pickedFileBytes;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocListener<SignupCubit, SignupState>(
          listener: (_, state) {
            if (state is SignupError) {
              context.showInAppNotifications(
                state.errorMessage,
              );
            } else if (state is SignupLoaded) {
              context.go(AppRoutes.chat);
            }
          },
        )
      ],
      child: MobileSignUpView(
        emailController: _emailController,
        nameController: _nameController,
        passwordController: _passwordController,
        pickedFileBytes: _pickedFileBytes,
        usernameController: _usernameController,
        pickImage: _pickImage,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _pickedFileBytes = await pickedFile.readAsBytes();
      setState(() {
        // _imageFile = ioHtml.File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MobileSignUpView extends StatelessWidget {
  const MobileSignUpView({
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.usernameController,
    required this.pickImage,
    required this.pickedFileBytes,
    super.key,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final Uint8List? pickedFileBytes;
  final void Function(ImageSource source) pickImage;

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
                    'TalkStream',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const YMargin(20),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const YMargin(6),
              const Text(
                'TalkStream is a versatile chat app that offers a '
                'seamless messaging experience for both personal and '
                'professional use. It was built using Dart Frog and Flutter.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const YMargin(40),
              Expanded(
                child: SingleChildScrollView(
                  child: SignUpView(
                    () {
                      context.go(AppRoutes.signIn);
                    },
                    pickImage,
                    emailController: emailController,
                    nameController: nameController,
                    passwordController: passwordController,
                    usernameController: usernameController,
                    // imageFile: _imageFile,
                    pickedFileBytes: pickedFileBytes,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

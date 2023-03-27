// **Web Version**
// *Still In Progres**
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_stream/app/src/constants/string_constant.dart';
import 'package:talk_stream/app/src/extensions/context_extensions.dart';

import 'package:talk_stream/app/view/widgets/custom_text_field.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/auth.dart';

import 'package:talk_stream/auth/cubits/auth_cubit.dart';

class WebSignUpWidget extends StatefulWidget {
  const WebSignUpWidget({
    required this.onSwitch,
    super.key,
  });
  final VoidCallback onSwitch;

  @override
  State<WebSignUpWidget> createState() => _WebSignUpWidgetState();
}

class _WebSignUpWidgetState extends State<WebSignUpWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  // ioHtml.File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _pickedFileBytes;

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
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) async {
          if (state is SignupError) {
            context.showInAppNotifications(
              state.errorMessage,
            );
          }
        },
        child: SignUpView(
          widget.onSwitch,
          _pickImage,
          emailController: _emailController,
          nameController: _nameController,
          usernameController: _usernameController,
          passwordController: _passwordController,
          // imageFile: _imageFile,
          pickedFileBytes: _pickedFileBytes,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView(
    this.onSwitch,
    this._pickImage, {
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.usernameController,
    required this.pickedFileBytes,
    super.key,
  });
  final VoidCallback onSwitch;
  final void Function(ImageSource source) _pickImage;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final Uint8List? pickedFileBytes;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Column(
      children: [
        GestureDetector(
          onTap: () => _pickImage(ImageSource.gallery),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFF1F1F1F),
            backgroundImage:
                pickedFileBytes != null ? MemoryImage(pickedFileBytes!) : null,
            child: pickedFileBytes == null
                ? const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  )
                : null,
          ),
        ),
        CustomTextField(
          label: AppString.username,
          icon: FontAwesomeIcons.user,
          hintText: AppString.enterUsername,
          controller: usernameController,
        ),
        const YMargin(24),
        CustomTextField(
          label: AppString.name,
          icon: FontAwesomeIcons.user,
          hintText: AppString.enterName,
          controller: nameController,
        ),
        const YMargin(24),
        CustomTextField(
          label: AppString.email,
          icon: FontAwesomeIcons.envelope,
          hintText: AppString.enterEmail,
          controller: emailController,
        ),
        const YMargin(24),
        CustomTextField(
          label: AppString.password,
          icon: FontAwesomeIcons.lock,
          hintText: AppString.enterPassword,
          controller: passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 44),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF121212),
                ),
                onPressed: () async {
                  if (pickedFileBytes == null) {
                    context.showInAppNotifications(
                      AppString.selectPicture,
                    );
                    return;
                  }
                  await context.read<SignupCubit>().signup(
                        User(
                          email: emailController.text,
                          name: nameController.text,
                          password: passwordController.text,
                          username: usernameController.text,
                          profileImage: String.fromCharCodes(pickedFileBytes!),
                        ),
                        authCubit,
                      );

                  // if (_formKey.currentState!.validate()) {
                  //   // submit the form
                  // }
                },
                child: state is SignupLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                       AppString.signUp,
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
                text: 'Already have an account? ',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFF121212),
                ),
                children: [
                  TextSpan(
                    text: 'Login here.',
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
    );
  }
}

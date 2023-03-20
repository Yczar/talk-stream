import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';

import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/chat/cubits/all_users_cubit.dart';
import 'package:talk_stream/chat/view/widgets/chat_item_widget.dart';

class MobileAllUsersPage extends StatelessWidget {
  const MobileAllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated && state.user.id != null) {
          return BlocProvider(
            create: (context) => AllUsersCubit()..fetchAllUsers(state.user.id!),
            lazy: false,
            child: const MobileAllUsersView(),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'An error occurred trying to authenticate user',
            ),
          ),
        );
      },
    );
  }
}

class MobileAllUsersView extends StatelessWidget {
  const MobileAllUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Users',
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
                child: BlocBuilder<AllUsersCubit, AllUsersState>(
                  builder: (context, state) {
                    if (state is AllUsersLoaded) {
                      return ListView.separated(
                        itemBuilder: (_, index) {
                          final user = state.users[index];
                          return ChatItemWidget(
                            onTap: () {
                              context.push(
                                AppRoutes.mobileChatDetails,
                                extra: {
                                  'user': user,
                                },
                              );
                            },
                            title: user.name?.toLowerCase(),
                            description: user.email,
                            profileImage: MemoryImage(
                              Uint8List.fromList(
                                user.profileImage!.codeUnits,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const YMargin(20),
                        itemCount: state.users.length,
                      );
                    } else if (state is AllUsersLoading) {
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
                    } else if (state is AllUsersError) {
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
    );
  }
}

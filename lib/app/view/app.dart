import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'package:talk_stream/app/core/locator.dart';
import 'package:talk_stream/app/core/services/services.dart';
import 'package:talk_stream/app/src/constants/app_routes.dart';
import 'package:talk_stream/auth/cubits/auth_cubit.dart';
import 'package:talk_stream/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouterService = locator<GoRouterService>();
    return Nested(
      children: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (_, state) {
            if (state is AuthAuthenticated) {
              goRouterService.router.go(AppRoutes.chat);
            } else if (state is AuthUnAuthenticated) {
              goRouterService.router.go(AppRoutes.splash);
            }
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF121212),
            elevation: 1,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
            primarySwatch: const MaterialColor(
              0xFF121212,
              _swatchColor,
            ),
          ),
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: goRouterService.router,
        // home: const CounterPage(),
      ),
    );
  }
}

const Map<int, Color> _swatchColor = {
  50: Color(0xFF121212),
  100: Color(0xFF121212),
  200: Color(0xFF121212),
  300: Color(0xFF121212),
  400: Color(0xFF121212),
  500: Color(0xFF121212),
  600: Color(0xFF121212),
  700: Color(0xFF121212),
  800: Color(0xFF121212),
  900: Color(0xFF121212),
};

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talk_stream/app/src/utils/app_utils.dart';

extension BuildContextExtension on BuildContext {
  bool get isWeb => kIsWeb;

  bool get isLargeScreen =>
      mediaQuery.size.width >= 900 && mediaQuery.size.height >= 600;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);
  void showInAppNotifications(String message) =>
      AppUtils.showInAppNotification(this, message);
}

import 'package:flutter/material.dart';
import 'package:talk_stream/app/src/utils/models/notification_type.dart';

import 'package:talk_stream/app/view/widgets/in_app_notification_widget.dart';

class AppUtils {
  static Future<void> showInAppNotification(
    BuildContext context,
    String message, {
    NotificationType type = NotificationType.error,
  }) async {
    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return InAppNotification(
          message: message,
          type: type,
        );
      },
    );
    Navigator.of(context).overlay?.insert(overlayEntry);
    await Future<dynamic>.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    overlayEntry.remove();
  }
}

import 'package:flutter/material.dart';
import 'package:talk_stream/app/src/utils/models/notification_type.dart';

class InAppNotification extends StatefulWidget {
  const InAppNotification({
    super.key,
    required this.message,
    required this.type,
  });
  final String message;
  final NotificationType type;

  @override
  State<StatefulWidget> createState() => InAppNotificationState();
}

class InAppNotificationState extends State<InAppNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    position =
        Tween<Offset>(begin: const Offset(0, -4), end: Offset.zero).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: SlideTransition(
              position: position,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: widget.type == NotificationType.error
                      ? const Color(0xFFb20000)
                      : const Color(0xFF1F1F1F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

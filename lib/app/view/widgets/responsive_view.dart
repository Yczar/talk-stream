import 'package:flutter/material.dart';

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({
    required this.mobileView,
    required this.webView,
    super.key,
  });
  final Widget mobileView;
  final Widget webView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = constraints.maxWidth;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: screenWidth < 600 ? mobileView : webView,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        );
      },
    );
  }
}

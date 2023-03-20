import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  const XMargin(
    this.value, {
    super.key,
  });
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}

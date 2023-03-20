import 'package:flutter/material.dart';

class YMargin extends StatelessWidget {
  const YMargin(
    this.value, {
    super.key,
  });
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}

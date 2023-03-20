import 'package:flutter/material.dart';

import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    required this.hintText,
    required this.icon,
    super.key,
    this.obscureText = false,
    this.controller,
  });
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF121212),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        if (widget.label.isNotEmpty) const YMargin(6),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            // labelText: widget.label,
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF7D8398).withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '${widget.label} is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}

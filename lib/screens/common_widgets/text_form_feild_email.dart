import 'package:flutter/material.dart';

class TextFormFieldEmail extends StatelessWidget {
  const TextFormFieldEmail({super.key, required TextEditingController email})
    : _email = email;

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0E91A1), width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (v) =>
          (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
    );
  }
}

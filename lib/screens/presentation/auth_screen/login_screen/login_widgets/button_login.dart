import 'package:flutter/material.dart';
import 'package:product_list_app/core/app_colors.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    super.key,
    required bool loading,
    required this.onPressed,
    required this.title,
  }) : _loading = loading;

  final bool _loading;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepCyan,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: _loading ? null : onPressed,
        child: _loading
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(title), // ✅ النص من الخارج
      ),
    );
  }
}

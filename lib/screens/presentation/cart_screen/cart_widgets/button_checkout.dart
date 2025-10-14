import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/auth/auth_state.dart';

class ButtonCheckOut extends StatelessWidget {
  const ButtonCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          final isAuthed = authState.isAuthed;
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepCyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                if (!isAuthed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please login to proceed to checkout'),
                    ),
                  );
                  context.push('/login');
                  return;
                }
                context.push('/checkout');
              },
              child: Text(isAuthed ? 'Checkout' : 'Login to Checkout'),
            ),
          );
        },
      ),
    );
  }
}

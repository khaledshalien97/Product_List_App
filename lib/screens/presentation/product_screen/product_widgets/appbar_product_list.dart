import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/auth/auth_state.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';

AppBar appBarProductList(BuildContext context) {
  return AppBar(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.deepCyan,
    title: Text('Products'),
    actions: [
      BlocBuilder<CartCubit, CartState>(
        buildWhen: (p, c) => p.items.length != c.items.length,
        builder: (_, cart) {
          final count = cart.items.fold<int>(0, (s, e) => s + e.qty);
          return Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.push('/cart'),
              ),
              if (count > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState.isAuthed) {
            return IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                context.read<AuthCubit>().signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
            );
          } else {
            return PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'login') context.push('/login');
                if (v == 'register') context.push('/register');
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'login', child: Text('Login')),
                PopupMenuItem(value: 'register', child: Text('Register')),
              ],
            );
          }
        },
      ),
    ],
  );
}

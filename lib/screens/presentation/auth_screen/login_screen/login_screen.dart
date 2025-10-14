import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/auth/auth_state.dart';
import 'package:product_list_app/screens/common_widgets/commo_app_bar.dart';
import 'package:product_list_app/screens/common_widgets/common_text_widget.dart';
import 'package:product_list_app/screens/common_widgets/logo_image.dart';
import 'package:product_list_app/screens/presentation/auth_screen/login_screen/login_widgets/button_login.dart';
import 'package:product_list_app/screens/common_widgets/text_form_feild_email.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: 'Login'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Welcome back!')));
            context.pop();
          } else if (state.status == AuthStatus.error &&
              state.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          final loading = state.status == AuthStatus.loading;
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: loginForm(loading, context),
            ),
          );
        },
      ),
    );
  }

  Form loginForm(bool loading, BuildContext context) {
    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logoImage(),
            const SizedBox(height: 30),
            commonTextWidget(
              text: "Login",
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            TextFormFieldEmail(email: _email),
            const SizedBox(height: 12),
            textFormFieldPasswordLogin(),
            const SizedBox(height: 60),
            ButtonAuth(
              loading: loading,
              onPressed: () {
                if (_form.currentState?.validate() ?? false) {
                  context.read<AuthCubit>().signIn(
                    _email.text.trim(),
                    _password.text.trim(),
                  );
                }
              },
              title: "Login",
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => context.push('/register'),
                child: commonTextWidget(
                  text: "Don't have an account? Register",
                  fontSize: 16,
                  color: AppColors.deepCyan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFormFieldPasswordLogin() {
    return TextFormField(
      controller: _password,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: 'Password',
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
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: (v) => (v == null || v.length < 6) ? 'Min 6 chars' : null,
    );
  }
}

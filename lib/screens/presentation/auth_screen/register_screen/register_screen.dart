import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/auth/auth_state.dart';
import 'package:product_list_app/screens/common_widgets/commo_app_bar.dart';
import 'package:product_list_app/screens/common_widgets/common_text_widget.dart';
import 'package:product_list_app/screens/common_widgets/logo_image.dart';
import 'package:product_list_app/screens/common_widgets/text_form_feild_email.dart';
import 'package:product_list_app/screens/presentation/auth_screen/login_screen/login_widgets/button_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      appBar: commonAppBar(title: 'Register'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, s) {
          if (s.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created. Welcome!')),
            );
            context.pop();
          } else if (s.status == AuthStatus.error && s.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(s.message!)));
          }
        },
        builder: (context, s) {
          final loading = s.status == AuthStatus.loading;
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoImage(),
                      const SizedBox(height: 30),
                      commonTextWidget(
                        text: "Register",
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldEmail(email: _email),
                      const SizedBox(height: 12),
                      textFormFieldPasswordRegister(),
                      const SizedBox(height: 60),
                      ButtonAuth(
                        loading: loading,
                        onPressed: () {
                          if (_form.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().signUp(
                              _email.text.trim(),
                              _password.text.trim(),
                            );
                          }
                        },
                        title: "Register",
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () => context.push('/login'),
                          child: commonTextWidget(
                            text: "Already have an account? Login",
                            color: AppColors.deepCyan,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField textFormFieldPasswordRegister() {
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

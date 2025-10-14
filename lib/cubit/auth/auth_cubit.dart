import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_list_app/data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  StreamSubscription<User?>? _sub;

  AuthCubit(this.repo) : super(const AuthState()) {
    _sub = repo.authStateChanges().listen((user) {
      if (user == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      } else {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      await repo.signIn(email: email, password: password);
   
    } on FirebaseAuthException catch (e) {
      emit(AuthState(status: AuthStatus.error, message: e.message));
      emit(
        const AuthState(status: AuthStatus.unauthenticated),
      ); 
    } catch (e) {
      emit(AuthState(status: AuthStatus.error, message: e.toString()));
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      await repo.signUp(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      emit(AuthState(status: AuthStatus.error, message: e.message));
      emit(const AuthState(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(AuthState(status: AuthStatus.error, message: e.toString()));
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signOut() async {
    await repo.signOut();
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? message;

  const AuthState({this.status = AuthStatus.unknown, this.user, this.message});

  AuthState copyWith({AuthStatus? status, User? user, String? message}) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        message: message,
      );

  bool get isAuthed => status == AuthStatus.authenticated && user != null;

  @override
  List<Object?> get props => [status, user?.uid, message];
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _fa;
  AuthRepository({FirebaseAuth? firebaseAuth})
    : _fa = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _fa.authStateChanges();
  User? get currentUser => _fa.currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) => _fa.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) => _fa.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _fa.signOut();
}

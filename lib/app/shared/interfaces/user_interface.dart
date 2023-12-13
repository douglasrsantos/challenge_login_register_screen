import 'package:firebase_auth/firebase_auth.dart';

abstract class IUser {
  Future<User?> register({
    required String email,
    required String password,
    String? userName,
    String? photoUrl,
  });
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> logout();
}

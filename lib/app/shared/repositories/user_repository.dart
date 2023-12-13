import 'dart:developer';

import 'package:challenge_register_screen/app/exception/auth_exception.dart';
import 'package:challenge_register_screen/app/shared/interfaces/user_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository implements IUser {
  final FirebaseAuth _firebaseAuth;

  UserRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register({
    required String email,
    required String password,
    String? userName,
    String? photoUrl,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(userName);
      await userCredential.user?.updatePhotoURL(photoUrl);
      await userCredential.user?.reload();

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());
      if (e.code == 'email-already-in-use') {
        throw AuthException(
          message: 'E-mail já utilizado, por favor escolha outro e-mail',
        );
      } else if (e.code == 'invalid-email') {
        throw AuthException(
          message: 'E-mail inválido!',
        );
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on PlatformException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Senha incorreta');
      } else if (e.code == 'user-not-found') {
        throw AuthException(message: 'Usuário não encontrado');
      } else if (e.code == 'channel-error') {
        throw AuthException(
            message:
                'Erro ao realizar login, Revise os dados informados e tente novamente.');
      } else if (e.code == 'invalid-email') {
        throw AuthException(message: 'E-mail inválido!');
      } else if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Senha Incorreta!');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      // final loginMethods =
      //     await _firebaseAuth.fetchSignInMethodsForEmail(email);

      // if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      // } else {
      //   throw AuthException(message: 'E-mail não cadastrado');
      // }
    } on PlatformException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw AuthException(message: 'Erro ao redefinir senha');
    }
  }

  @override
  Future<void> logout() async {
    _firebaseAuth.signOut();
  }
}

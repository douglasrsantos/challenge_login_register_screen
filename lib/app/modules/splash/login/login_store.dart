// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:challenge_register_screen/app/exception/auth_exception.dart';
import 'package:challenge_register_screen/app/exception/messages.dart';
import 'package:challenge_register_screen/app/shared/interfaces/user_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final userRepository = Modular.get<IUser>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final keyFormLogin = GlobalKey<FormState>();

  @observable
  bool isObscureText = true;

  @observable
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    isLoading = true;
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      if (keyFormLogin.currentState!.validate() == false) {
        isLoading = false;
        return Messages.of(context).showError(
          'Você precisa preencher os campos indicados!',
        );
      }

      final user = await userRepository.login(
          emailController.text, passwordController.text);

      if (user != null) {
        log(user.toString());
        emailController.text = '';
        passwordController.text = '';
        isLoading = false;
        Modular.to.navigate('/home/', arguments: user);
      } else {
        isLoading = false;
        log('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      isLoading = false;
      Messages.of(context).showError(e.message);
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    isLoading = true;
    try {
      if (emailController.text.trim() == '') {
        isLoading = false;
        Messages.of(context)
            .showError('Digite um e-mail para recuperar a senha');
      }
      await userRepository.forgotPassword(emailController.text);
      isLoading = false;
      Messages.of(context)
          .showInfo('Redefinição de senha enviado para o seu e-mail');
    } on AuthException catch (e) {
      isLoading = false;
      Messages.of(context).showError(e.message);
    } catch (e) {
      isLoading = false;
      Messages.of(context).showError('Erro ao redefinir senha');
    }
  }

  toggleIsObscureText() {
    isObscureText = !isObscureText;
  }
}

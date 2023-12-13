// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:challenge_register_screen/app/exception/auth_exception.dart';
import 'package:challenge_register_screen/app/exception/messages.dart';
import 'package:challenge_register_screen/app/shared/interfaces/user_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

// ignore: library_private_types_in_public_api
class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final userRepository = Modular.get<IUser>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final localizationController = TextEditingController();

  final keyFormRegister = GlobalKey<FormState>();

  @observable
  File? imageFile;

  @observable
  bool isLoading = false;

  @observable
  bool isObscureText = true;

  Future<void> registerUser(BuildContext context) async {
    try {
      isLoading = true;
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      if (keyFormRegister.currentState!.validate() == false) {
        isLoading = false;
        return Messages.of(context).showError(
          'Você precisa preencher os campos indicados!',
        );
      }

      final user = await userRepository.register(
        email: emailController.text,
        password: passwordController.text,
        userName: nameController.text,
        photoUrl: imageFile?.path,
      );

      if (user != null) {
        log('Usuário cadastrado');
        isLoading = false;
        Messages.of(context).showInfo(
          'Usuário cadastrado!',
        );
        Modular.to.pop();
      } else {
        log('Erro ao cadastrar usuário');
      }
    } on AuthException catch (e) {
      isLoading = false;
      Messages.of(context).showError(e.message);
    }
  }

  toggleIsObscureText() {
    isObscureText = !isObscureText;
  }
}

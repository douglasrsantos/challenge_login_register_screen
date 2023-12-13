import 'dart:developer';

import 'package:challenge_register_screen/app/shared/interfaces/user_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final userRepository = Modular.get<IUser>();

  @observable
  bool isLoading = false;

  Future<void> logout() async {
    isLoading = true;
    try {
      await userRepository.logout();

      isLoading = false;
      Modular.to.pushNamed('/login');
    } catch (e) {
      isLoading = false;
      log(e.toString());
    }
  }
}

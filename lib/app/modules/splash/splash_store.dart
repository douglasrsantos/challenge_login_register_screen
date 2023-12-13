import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

// ignore: library_private_types_in_public_api
class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  @observable
  double opacity = 1;

  @action
  init() async {
    await doAnimation();
    Modular.to.navigate('/login');
  }

  Future doAnimation() async {
    opacity = 0;
    await Future.delayed(const Duration(milliseconds: 300));

    opacity = 1;
    await Future.delayed(const Duration(milliseconds: 1300));
  }
}

import 'package:challenge_register_screen/app/modules/splash/splash_module.dart';
import 'package:challenge_register_screen/app/shared/interfaces/user_interface.dart';
import 'package:challenge_register_screen/app/shared/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance(FirebaseAuth.instance);
    i.addSingleton<IUser>(UserRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: SplashModule());
  }
}

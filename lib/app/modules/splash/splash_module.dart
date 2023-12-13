import 'package:challenge_register_screen/app/modules/home/home_module.dart';
import 'package:challenge_register_screen/app/modules/splash/login/login_page.dart';
import 'package:challenge_register_screen/app/modules/splash/login/login_store.dart';
import 'package:challenge_register_screen/app/modules/splash/register/register_page.dart';
import 'package:challenge_register_screen/app/modules/splash/register/register_store.dart';
import 'package:challenge_register_screen/app/modules/splash/splash_page.dart';
import 'package:challenge_register_screen/app/modules/splash/splash_store.dart';
import 'package:challenge_register_screen/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(SplashStore.new);
    i.addSingleton(LoginStore.new);
    i.add(RegisterStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/home', module: HomeModule());
    r.child('/', child: (_) => SplashPage(controller: Modular.get()));
    r.child('/login', child: (_) => LoginPage(controller: Modular.get()));
    r.child('/register', child: (_) => RegisterPage(controller: Modular.get()));
  }
}

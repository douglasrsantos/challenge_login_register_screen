import 'package:challenge_register_screen/app/modules/home/home_page.dart';
import 'package:challenge_register_screen/app/modules/home/home_store.dart';
import 'package:challenge_register_screen/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => HomePage(controller: Modular.get(), user: r.args.data));
  }
}

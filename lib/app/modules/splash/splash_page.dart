import 'package:challenge_register_screen/app/modules/splash/splash_store.dart';
import 'package:challenge_register_screen/app/shared/core/app_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SplashPage extends StatefulWidget {
  final SplashStore controller;

  const SplashPage({super.key, required this.controller});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashStore get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: AppGradients.visual),
        child: Observer(builder: (_) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 1300),
            curve: Curves.easeIn,
            opacity: controller.opacity,
            child: Image.asset(
              'assets/images/logo.png',
              width: 101,
              fit: BoxFit.contain,
            ),
          );
        }),
      ),
    );
  }
}

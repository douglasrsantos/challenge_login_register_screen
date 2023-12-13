import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Visual',
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.primary,
          scaffoldBackgroundColor: AppColors.beige,
        ),
    );
  }
}

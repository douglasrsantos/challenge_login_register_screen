import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:challenge_register_screen/app_module.dart';
import 'package:challenge_register_screen/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AppGradients {
  static LinearGradient visual = LinearGradient(
    colors: [AppColors.darkBlueGradient, AppColors.lightBlueGradient],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

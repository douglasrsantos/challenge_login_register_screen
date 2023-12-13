import 'package:flutter/material.dart';

class AppColors {
  static final Map<int, Color> _primary = {
    50: const Color.fromRGBO(8, 43, 76, .1),
    100: const Color.fromRGBO(8, 43, 76, .2),
    200: const Color.fromRGBO(8, 43, 76, .3),
    300: const Color.fromRGBO(8, 43, 76, .4),
    400: const Color.fromRGBO(8, 43, 76, .5),
    500: const Color.fromRGBO(8, 43, 76, .6),
    600: const Color.fromRGBO(8, 43, 76, .7),
    700: const Color.fromRGBO(8, 43, 76, .8),
    800: const Color.fromRGBO(8, 43, 76, .9),
    900: const Color.fromRGBO(8, 43, 76, 1),
  };

  static MaterialColor primary = MaterialColor(0xFF082B4C, _primary);

  static Color primaryARGB = const Color(0xFF082B4C);
  static Color beige = const Color(0xFFD7CCBD);

  static Color darkBlueGradient = const Color(0xFF082B4C);
  static Color lightBlueGradient = const Color(0xFF3D6E9B);
}

import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle textBold = GoogleFonts.roboto(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );

  static TextStyle textBoldWhite = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );

  static TextStyle text = GoogleFonts.roboto(
    color: AppColors.primary. withAlpha(100),
    fontSize: 16,
  );

  static TextStyle textBigger = GoogleFonts.roboto(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  static TextStyle profileName = GoogleFonts.roboto(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );
}

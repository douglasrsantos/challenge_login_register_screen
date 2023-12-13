import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:challenge_register_screen/app/shared/core/app_fonts.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final Function()? onPressedIconButton;
  final bool? obscureText;
  final bool? needSuffixIcon;
  final String? Function(String?)? validator;

  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.onPressedIconButton,
    this.obscureText,
    this.needSuffixIcon,
    this.validator,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        label: Text(widget.label),
        hintStyle: AppFonts.text,
        labelStyle: TextStyle(color: AppColors.primary),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(6),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        suffixIcon:
            (widget.needSuffixIcon != null && widget.needSuffixIcon == true)
                ? IconButton(
                    onPressed: widget.onPressedIconButton,
                    icon: Icon(
                      widget.obscureText != null && widget.obscureText == true
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : null,
        suffixIconColor: AppColors.primary,
      ),
      obscureText: widget.obscureText ?? false,
      style: AppFonts.textBold,
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}

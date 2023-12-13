import 'package:challenge_register_screen/app/modules/splash/login/login_store.dart';
import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:challenge_register_screen/app/shared/core/app_fonts.dart';
import 'package:challenge_register_screen/app/shared/widgets/auth_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  final LoginStore controller;
  const LoginPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(builder: (_) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Image.asset(
                            'assets/images/logo.png',
                          ),
                        ),
                        Text(
                          'Challenge',
                          style: AppFonts.textBigger,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: controller.keyFormLogin,
                    child: Column(
                      children: [
                        AuthTextFormField(
                          hintText: 'challenge@email.com',
                          label: 'E-mail',
                          controller: controller.emailController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'O campo e-mail deve ser preenchido corretamente!';
                            } else if (!value.contains('@')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Observer(builder: (_) {
                          return AuthTextFormField(
                            hintText: '******',
                            label: 'Senha',
                            controller: controller.passwordController,
                            needSuffixIcon: true,
                            onPressedIconButton: controller.toggleIsObscureText,
                            obscureText: controller.isObscureText,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'O campo senha deve ser preenchido corretamente!';
                              } else if (value.length < 6) {
                                return 'Senha deve conter no mínimo 6 caracteres';
                              }
                              return null;
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  controller.forgotPassword(context),
                              child: Text(
                                'Esqueci minha senha!',
                                style: AppFonts.text.copyWith(
                                  color: AppColors.primary.withAlpha(200),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.emailController.text = '';
                                controller.passwordController.text = '';
                                Modular.to.pushNamed('/register');
                              },
                              child: Text(
                                'Cadastre-se!',
                                style: AppFonts.text.copyWith(
                                  color: AppColors.primary.withAlpha(200),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () => controller.login(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: Text(
                              'ENTRAR',
                              style: AppFonts.textBoldWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

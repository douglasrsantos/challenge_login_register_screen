// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:challenge_register_screen/app/modules/splash/register/register_store.dart';
import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:challenge_register_screen/app/shared/core/app_fonts.dart';
import 'package:challenge_register_screen/app/shared/widgets/auth_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterPage extends StatelessWidget {
  final RegisterStore controller;

  const RegisterPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final _picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        leading: Observer(builder: (_) {
          if (controller.isLoading) {
            return const SizedBox.shrink();
          }

          return IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(
              Icons.reply_outlined,
              size: 48,
              color: AppColors.primary,
            ),
          );
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Observer(builder: (_) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Criar Conta',
                  style: AppFonts.textBigger,
                ),
                const SizedBox(height: 16),
                Form(
                  key: controller.keyFormRegister,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return CardImagePicker(
                                onTapCamera:  () async {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera);

                                  if (pickedFile != null) {
                                    controller.imageFile =
                                        File(pickedFile.path);
                                    Modular.to.pop();

                                    final editedImage = await Modular.to.push(
                                      MaterialPageRoute(
                                        builder: (context) => ImageEditor(
                                          image: controller.imageFile,
                                        ),
                                      ),
                                    );

                                    Directory tempDir =
                                        await getTemporaryDirectory();
                                    final timestamp = DateTime.now();
                                    File tempFile = File(
                                        '${tempDir.path}/temp_file_$timestamp.jpg');
                                    await tempFile.writeAsBytes(editedImage);

                                    if (editedImage != null) {
                                      controller.imageFile = null;
                                      controller.imageFile = tempFile;
                                    }
                                  }
                                },
                                onTapGallery: () async {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    controller.imageFile =
                                        File(pickedFile.path);
                                    Modular.to.pop();

                                    final editedImage = await Modular.to.push(
                                      MaterialPageRoute(
                                        builder: (context) => ImageEditor(
                                          image: controller.imageFile,
                                        ),
                                      ),
                                    );

                                    Directory tempDir =
                                        await getTemporaryDirectory();
                                    final timestamp = DateTime.now();
                                    File tempFile = File(
                                        '${tempDir.path}/temp_file_$timestamp.jpg');
                                    await tempFile.writeAsBytes(editedImage);

                                    if (editedImage != null) {
                                      controller.imageFile = null;
                                      controller.imageFile = tempFile;
                                    }
                                  }
                                },
                              );
                            },
                          );
                        }, //controller.addImage,
                        child: Container(
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.primary.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Observer(builder: (_) {
                            if (controller.imageFile != null) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  controller.imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColors.primary,
                                size: 64,
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormField(
                        hintText: 'José da Silva',
                        label: 'Nome',
                        controller: controller.nameController,
                      ),
                      const SizedBox(height: 16),
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
                      AuthTextFormField(
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
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () => controller.registerUser(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text(
                            'CADASTRAR',
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
    );
  }
}

class CardImagePicker extends StatefulWidget {
  final Function()? onTapGallery;
  final Function()? onTapCamera;

  const CardImagePicker({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  @override
  State<CardImagePicker> createState() => _CardImagePickerState();
}

class _CardImagePickerState extends State<CardImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: widget.onTapGallery,
              child: Row(
                children: [
                  Icon(
                    Icons.photo_album,
                    size: 32,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Galeria',
                    style: AppFonts.profileName,
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2),
            InkWell(
              onTap: widget.onTapCamera,
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 32,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Câmera',
                    style: AppFonts.profileName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> pickImage() async {
  final picker = ImagePicker();

  final pickedFile = await picker.pickImage(
      source: ImageSource.gallery); // ou ImageSource.camera para tirar uma foto

  if (pickedFile != null) {
    // Você tem o arquivo da imagem selecionada.
    // Agora, você pode exibir a imagem e fornecer opções de edição.
  }
}

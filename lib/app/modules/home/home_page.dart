import 'dart:io';

import 'package:challenge_register_screen/app/modules/home/home_store.dart';
import 'package:challenge_register_screen/app/shared/core/app_colors.dart';
import 'package:challenge_register_screen/app/shared/core/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatelessWidget {
  final User? user;
  final HomeStore controller;
  const HomePage({super.key, required this.controller, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Observer(builder: (_) {
            if (controller.isLoading) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                onPressed: controller.logout,
                icon: Icon(
                  Icons.logout,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Observer(builder: (_) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.primary.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(user?.photoURL ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user?.displayName ?? '',
                style: AppFonts.profileName,
              ),
              const SizedBox(height: 16),
              Text(
                user?.email ?? '',
                style: AppFonts.textBold,
              ),
            ],
          );
        }),
      ),
    );
  }
}

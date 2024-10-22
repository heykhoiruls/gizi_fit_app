// ignore_for_file: use_build_context_synchronously,
// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/components_modal_bottom.dart';

import '../../components/components_button.dart';
import '../../components/components_empty.dart';
import '../../components/components_header.dart';
import '../../components/components_input.dart';
import '../../configs/config_apps.dart';
import '../../models/model_controller.dart';

class PageForgotPassword extends StatefulWidget {
  const PageForgotPassword({super.key});

  @override
  State<PageForgotPassword> createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  @override
  Widget build(BuildContext context) {
    ModelController user = ModelController();
    @override
    void dispose() {
      user.controllerEmail.dispose();
      super.dispose();
    }

    Future passwordReset() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: user.controllerEmail.text.trim(),
        );
        modalBottom(
          context,
          "Password reset link send, check your email",
          null,
          null,
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        String errorMessage =
            e.message ?? "Terjadi kesalahan yang tidak terduga";
        switch (e.code) {
          case "channel-error":
            errorMessage = messageAuthError;
            break;
          case "invalid-email":
            errorMessage = messageEmailInvalid;
            break;
          case "invalid-credential":
            errorMessage = messageAuthinvalid;
            break;
          default:
            break;
        }

        modalBottom(
          context,
          errorMessage,
          null,
          null,
        );
      }
    }

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ComponentsHeader(text: "Lupa Kata Sandi"),
            const ComponentsEmpty(
              photo: imageForgotPassword,
              text: messageForgotPassword,
            ),
            const SizedBox(height: defaultSize),
            Column(
              children: [
                ComponentsInput(
                  controller: user.controllerEmail,
                  textTitle: "Email",
                  textObscure: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultSize,
                    right: defaultSize,
                    bottom: defaultSize,
                  ),
                  child: ComponentsButton(
                    text: "Ubah Kata Sandi",
                    onTap: passwordReset,
                    color: colorBackground,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors,
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../components/components_auth_question.dart';
import '../../components/components_sign_in_with.dart';
import '../../components/components_auth_header.dart';
import '../../components/components_transition.dart';
import '../../components/components_button.dart';
import '../../components/components_input.dart';
import '../../configs/config_apps.dart';
import '../../configs/config_components.dart';
import 'page_forgot_password.dart';
import 'page_sign_up.dart';

class PageSignIn extends StatelessWidget {
  const PageSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ComponentsAuthHeader(
                textPage: "Masuk",
                textTitle: "Selamat datang di Gizi Fit",
              ),
              SizedBox(height: defaultSize * 3),
              ComponentsInput(
                controller: user.controllerEmail,
                textTitle: "Email",
                textObscure: false,
              ),
              ComponentsInput(
                controller: user.controllerPassword,
                textTitle: "Kata Sandi",
                textObscure: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSize * 1.5,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            transitionRight(
                              PageForgotPassword(),
                            ),
                          );
                        },
                        child: ConfigText(
                          configFontText: "Lupa kata sandi ?",
                          configFontColor: colorTextAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: defaultSize * 3),
                    ComponentsButton(
                      text: "Masuk",
                      color: colorBackground,
                      onTap: () {
                        controllerUser.signUserIn(context, user);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultSize * 4),
              ComponentsSignInWith(),
              SizedBox(height: defaultSize * 4),
              ComponentsAuthQuestion(
                textQuestion: "belum punya akun ? ",
                textStatement: "Buat sekarang",
                onTap: () {
                  Navigator.push(
                    context,
                    transitionRight(
                      PageSignUp(),
                    ),
                  );
                  user.controllerEmail.clear();
                  user.controllerPassword.clear();
                },
              ),
              SizedBox(height: defaultSize * 3),
            ],
          ),
        ),
      ),
    );
  }
}

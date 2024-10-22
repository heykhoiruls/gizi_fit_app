// ignore_for_file: prefer_const_constructors
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../components/components_auth_question.dart';
import '../../components/components_auth_header.dart';
import '../../components/components_transition.dart';
import '../../components/components_category.dart';
import '../../components/components_button.dart';
import '../../pages/page_auth/page_sign_in.dart';
import '../../components/components_input.dart';
import '../../configs/config_apps.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  int selectedGenderIndex = 0;
  int selectedRoleIndex = 0;

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
                textPage: "Daftar",
                textTitle: "Bergabung dengan Gizi Fit",
              ),
              SizedBox(height: defaultSize * 3),
              Column(
                children: [
                  ComponentsInput(
                    controller: user.controllerName,
                    textTitle: "Nama Lengkap",
                    textObscure: false,
                  ),
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
                ],
              ),
              ComponentsCategory(
                text: "Jenis Kelamin",
                onCategorySelected: (index) {
                  setState(() {
                    selectedGenderIndex = index;
                  });
                },
              ),
              ComponentsCategory(
                text: "Peran",
                onCategorySelected: (index) {
                  setState(() {
                    selectedRoleIndex = index;
                  });
                },
              ),
              SizedBox(height: defaultSize),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSize * 1.25,
                ),
                child: ComponentsButton(
                  text: "Daftar",
                  color: colorBackground,
                  onTap: () {
                    controllerUser.userSignUp(
                      context,
                      user,
                      list.role[selectedRoleIndex],
                      list.gender[selectedGenderIndex],
                    );
                  },
                ),
              ),
              SizedBox(height: defaultSize * 10),
              ComponentsAuthQuestion(
                textQuestion: "sudah punya akun ? ",
                textStatement: "Masuk disini",
                onTap: () {
                  Navigator.push(
                    context,
                    transitionRight(
                      PageSignIn(),
                    ),
                  );
                  user.controllerName.clear();
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

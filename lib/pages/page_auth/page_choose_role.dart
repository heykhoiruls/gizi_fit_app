// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../configs/config_components.dart';
import '../../components/components_category.dart';
import '../../components/components_button.dart';
import '../../components/components_decision.dart';
import '../../components/components_modal_bottom.dart';
import '../../components/components_transition.dart';
import '../../configs/config_apps.dart';
import 'page_auth.dart';

class PageChooseRole extends StatefulWidget {
  const PageChooseRole({super.key});

  @override
  State<PageChooseRole> createState() => _PageChooseRoleState();
}

class _PageChooseRoleState extends State<PageChooseRole> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  int selectedGenderIndex = 0;
  int selectedRoleIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultSize,
                vertical: defaultSize,
              ),
              child: ComponentsButton(
                text: 'Lengkapi data diri',
                color: colorBackground,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: defaultSize * 6),
                    SvgPicture.asset(
                      imageChooseRole,
                      width: 250.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: defaultSize),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultSize * 1.5,
                      ),
                      child: ConfigText(configFontText: messageChooseRole),
                    ),
                    const SizedBox(height: defaultSize * 3),
                    Column(
                      children: [
                        ComponentsCategory(
                          text: "Jenis Kelamin",
                          onCategorySelected: (index) {
                            setState(() {
                              selectedGenderIndex = index;
                            });
                          },
                        ),
                        const SizedBox(height: defaultSize),
                        ComponentsCategory(
                          text: "Peran",
                          onCategorySelected: (index) {
                            setState(() {
                              selectedRoleIndex = index;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: defaultSize,
                right: defaultSize,
                bottom: defaultSize * 2,
                top: defaultSize * 0.75,
              ),
              child: ComponentsDecision(
                textLeft: "Masuk",
                textRight: "Keluar",
                onTapLeft: () {
                  controllerUser.streamUsers.doc(currentUser.uid).update({
                    "role": list.role[selectedRoleIndex],
                    "gender": list.gender[selectedGenderIndex],
                  });
                },
                onTapRight: () {
                  modalBottom(
                    context,
                    messageSignOut,
                    FirebaseAuth.instance.currentUser?.uid,
                    () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        transitionRight(
                          const PageAuth(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

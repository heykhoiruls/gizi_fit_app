// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/components_button.dart';
import '../../components/components_decision.dart';
import '../../components/components_modal_bottom.dart';
import '../../components/components_transition.dart';
import '../../pages/page_auth/page_role_validation.dart';
import '../../components/components_empty.dart';
import '../../configs/config_apps.dart';
import 'page_auth.dart';

class PageEmailVerification extends StatefulWidget {
  final String id;
  const PageEmailVerification({
    super.key,
    required this.id,
  });

  @override
  State<PageEmailVerification> createState() => _PageEmailVerificationState();
}

class _PageEmailVerificationState extends State<PageEmailVerification> {
  bool isVerify = false;
  Timer? timer;
  bool canSend = false;

  @override
  void initState() {
    super.initState();

    isVerify = true;
    // isVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerify) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmail());
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerify) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canSend = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canSend = true);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isVerify
        ? PageRoleValidation(id: widget.id)
        : Scaffold(
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
                      text: "Verifikasi Email Anda",
                      color: colorBar,
                    ),
                  ),
                  const ComponentsEmpty(
                    photo: imageEmailVerification,
                    text: messageEmailVerification,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: defaultSize,
                      right: defaultSize,
                      bottom: defaultSize * 2,
                      top: defaultSize * 0.75,
                    ),
                    child: ComponentsDecision(
                      textLeft: "Kirim Ulang",
                      textRight: "Keluar",
                      onTapLeft: canSend
                          ? () {
                              sendVerificationEmail();
                            }
                          : () {},
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

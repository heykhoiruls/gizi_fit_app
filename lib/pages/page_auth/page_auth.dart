// ignore_for_file: file_names
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_cast
// ignore_for_file: unrelated_type_equality_checks
// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/page_auth/page_email_verification.dart';
import 'page_sign_in.dart';

class PageAuth extends StatelessWidget {
  const PageAuth({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageEmailVerification(
              id: FirebaseAuth.instance.currentUser!.uid,
            );
          } else {
            return PageSignIn();
          }
        },
      ),
    );
  }
}

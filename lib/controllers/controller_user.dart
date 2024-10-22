// ignore_for_file: use_build_context_synchronously,
// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gizi_fit_app/controllers/controller_immunization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components_modal_bottom.dart';
import '../components/components_transition.dart';
import '../configs/config_apps.dart';
import '../pages/page_auth/page_auth.dart';
import '../models/model_controller.dart';

class ControllerUser {
  // -------------------- users

  final streamUsers = FirebaseFirestore.instance.collection("users");

  // -------------------- user sign up

  void userSignUp(
    BuildContext context,
    ModelController user,
    String role,
    String gender,
  ) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.controllerEmail.text,
        password: user.controllerPassword.text,
      );

      final token = await FirebaseMessaging.instance.getToken();

      await streamUsers.doc(auth.currentUser!.uid).set(
        {
          "uid": auth.currentUser!.uid,
          "name": user.controllerName.text,
          "email": user.controllerEmail.text,
          "role": role,
          "gender": gender,
          "nik": messageDefault,
          "token": token,
          "birthPlace": messageDefault,
          "photo": (gender == "Perempuan") ? imagePhotoGirl : imagePhotoBoy,
          "birthDate": Timestamp.now(),
          "timestamp": Timestamp.now(),
        },
      );

      if (role == "Anak Panti") {
        ControllerImmunization().add(auth.currentUser!.uid);
      }

      await Navigator.push(
        context,
        transitionLeft(
          const PageAuth(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "Terjadi kesalahan yang tidak terduga";
      switch (e.code) {
        case "email-already-in-use":
          errorMessage = messageEmailAlreadyUse;
          break;
        case "network-request-failed":
          errorMessage = messageNoInternet;
          break;
        case "invalid-email":
          errorMessage = messageEmailInvalid;
          break;
        case "channel-error":
          errorMessage = messageAuthError;
          break;
        case "weak-password":
          errorMessage = messagPassAlert;
          break;
        default:
          break;
      }

      modalBottom(
        context,
        errorMessage,
        null,
        () {},
      );
    }
  }

  // -------------------- user sign in

  void signUserIn(BuildContext context, ModelController user) async {
    try {
      final email = user.controllerEmail.text.trim();
      final password = user.controllerPassword.text.trim();

      if (email.isEmpty || password.isEmpty) {
        modalBottom(
          context,
          messageEmailAndPasswordEmpty,
          null,
          () {},
        );
        return;
      }
      final FirebaseAuth auth = FirebaseAuth.instance;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final token = await FirebaseMessaging.instance.getToken();

      await streamUsers.doc(auth.currentUser!.uid).update(
        {
          "token": token,
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "Terjadi kesalahan yang tidak terduga";
      switch (e.code) {
        case "channel-error":
          errorMessage = messageAuthError;
          break;
        case "network-request-failed":
          errorMessage = messageNoInternet;
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
        () {},
      );
    } catch (e) {
      modalBottom(
        context,
        "An unexpected error occurred",
        null,
        () {},
      );
    }
  }

  // -------------------- user sign in with google

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    print("---1");
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (googleUser == null) {
      modalBottom(
        context,
        messageSignInWithGoogleCancelled,
        null,
        () {},
      );
      return null;
    }
    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final token = await FirebaseMessaging.instance.getToken();

      final user = controllerUser.streamUsers.doc(auth.currentUser!.uid);
      final userDoc = await user.get();

      if (userDoc.exists) {
        await user.update({
          "token": token,
        });
      }

      if (!userDoc.exists) {
        await user.set({
          "uid": auth.currentUser!.uid,
          "name": userCredential.user!.displayName!,
          "email": userCredential.user!.email!,
          "nik": messageDefault,
          "token": token,
          "birthPlace": messageDefault,
          "photo": userCredential.user!.photoURL,
          "birthDate": Timestamp.now(),
          "timestamp": Timestamp.now(),
        });
      }
      await Navigator.push(
        context,
        transitionLeft(const PageAuth()),
      );
      return userCredential;
    } catch (e) {
      print("Error during sign-in: $e");
    }
    return null;
  }
}

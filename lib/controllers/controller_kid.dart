import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../models/model_controller.dart';

class ControllerKid {
  final streamKids = FirebaseFirestore.instance.collection('kids');

  void add(
    BuildContext context,
    ModelController user,
    Timestamp birthDate,
    String gender,
    String parentName,
  ) async {
    final DocumentReference reference = streamKids.doc();

    final String documentId = reference.id;

    await reference.set({
      "uid": documentId,
      "name": user.name,
      "gender": gender,
      "nik": user.nik,
      "idParent": parentName,
      "photo": (gender == "Perempuan") ? imagePhotoGirl : imagePhotoBoy,
      "placeBirth": user.birthPlace,
      "birthDate": birthDate,
      "timestamp": Timestamp.now(),
    });

    user.clearTextControllers();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}

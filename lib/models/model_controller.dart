import 'package:flutter/material.dart';

import '../configs/config_apps.dart';

class ModelController {
  TextEditingController controllerCardNumber = TextEditingController();
  TextEditingController controllerBirthPlace = TextEditingController();
  TextEditingController controllerBirthDate = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerMessage = TextEditingController();
  TextEditingController controllerGender = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerSearch = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerTotalNutrition = TextEditingController();

  String name = messageDefault;
  String nik = messageDefault;
  String birthPlace = messageDefault;

  void clearTextControllers() {
    controllerEmail.clear();
    controllerPassword.clear();
    controllerName.clear();
    controllerCardNumber.clear();
    controllerGender.clear();
    controllerBirthPlace.clear();
    controllerBirthDate.clear();
    controllerHeight.clear();
    controllerWeight.clear();
    controllerSearch.clear();
    controllerTotalNutrition.clear();

    name = messageDefault;
    nik = messageDefault;
    birthPlace = messageDefault;
  }
}

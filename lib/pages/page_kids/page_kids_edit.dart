// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../components/components_data_kids_edit.dart';
import '../../components/components_header.dart';
import '../../configs/config_apps.dart';
import '../../models/model_list.dart';

class PageKidsEdit extends StatelessWidget {
  final String id;
  PageKidsEdit({super.key, required this.id});

  ModelList list = ModelList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ComponentsHeader(text: "Perbarui data anak"),
            ComponentsDataKidsEdit(id: id),
          ],
        ),
      ),
    );
  }
}

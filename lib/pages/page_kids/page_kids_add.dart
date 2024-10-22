import 'package:flutter/material.dart';

import '../../components/components_data_kids_add.dart';
import '../../components/components_header.dart';
import '../../configs/config_apps.dart';

class PageKidsAdd extends StatelessWidget {
  const PageKidsAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsHeader(text: "Tambah data anak"),
            ComponentsDataKidsAdd(),
          ],
        ),
      ),
    );
  }
}

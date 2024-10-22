// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../components/components_data_kids_detail.dart';
import '../../components/components_header.dart';
import '../../configs/config_apps.dart';

class PageKidsDetail extends StatelessWidget {
  final String id;
  const PageKidsDetail({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ComponentsHeader(text: "Detail data anak"),
            ComponentsDataKidsDetail(id: id),
          ],
        ),
      ),
    );
  }
}

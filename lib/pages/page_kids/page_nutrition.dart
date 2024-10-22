import 'package:flutter/material.dart';

import '../../components/components_header.dart';
import '../../components/components_list_nutrition.dart';
import '../../configs/config_apps.dart';

class PageNutrition extends StatefulWidget {
  final String id;
  const PageNutrition({required this.id, super.key});

  @override
  State<PageNutrition> createState() => _PageNutritionState();
}

class _PageNutritionState extends State<PageNutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
          child: Column(
        children: [
          const ComponentsHeader(text: "Daftar Nutrisi"),
          ComponentsListNutrition(id: widget.id)
        ],
      )),
    );
  }
}

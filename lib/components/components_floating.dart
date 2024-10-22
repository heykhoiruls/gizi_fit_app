import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';

import '../components/components_transition.dart';
import '../pages/page_kids/page_kids_record.dart';
import '../configs/config_apps.dart';

class ComponentsFloating extends StatelessWidget {
  final String id;
  const ComponentsFloating({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          transitionRight(
            PageKidsRecord(id: id),
          ),
        );
      },
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(defaultRadius),
        color: colorPrimary,
        child: const Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Icon(
            LineIcons.plus,
            color: colorBackground,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}

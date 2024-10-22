import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsTitlePage extends StatelessWidget {
  final String title;
  const ComponentsTitlePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: colorPrimary),
      child: Padding(
        padding: const EdgeInsets.only(
          top: defaultSize * 4,
          left: defaultSize * 2,
          right: defaultSize * 2,
          bottom: defaultSize * 1.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConfigText(
                  configFontText: title,
                  configFontColor: colorBackground,
                  configFontSize: defaultSize * 1.1,
                  configFontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

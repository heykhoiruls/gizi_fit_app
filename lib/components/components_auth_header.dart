import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsAuthHeader extends StatelessWidget {
  final String textTitle;
  final String textPage;

  const ComponentsAuthHeader({
    super.key,
    required this.textTitle,
    required this.textPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize * 1.5,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: defaultSize * 5),
            ConfigText(
              configFontText: textPage,
              configFontSize: defaultSize * 3,
              configFontWeight: FontWeight.w600,
            ),
            ConfigText(
              configFontText: textTitle,
              configFontSize: defaultSize * 1.2,
              configFontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

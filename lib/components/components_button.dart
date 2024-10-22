import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onTap;
  const ComponentsButton({
    this.color,
    this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: [defaultShadow],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: defaultSize * 1.2,
        ),
        child: Center(
          child: ConfigText(
            configFontText: text,
            configFontSize: defaultSize,
            configFontWeight: FontWeight.w600,
            configFontColor: color,
          ),
        ),
      ),
    );
  }
}

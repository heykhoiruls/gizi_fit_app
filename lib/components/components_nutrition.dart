import 'package:flutter/material.dart';
import 'package:gizi_fit_app/configs/config_apps.dart';
import 'package:gizi_fit_app/configs/config_components.dart';

class ComponentsNutrition extends StatelessWidget {
  final String name;
  final String photo;
  final String time;
  final Function()? onTap;
  const ComponentsNutrition({
    required this.name,
    required this.photo,
    required this.time,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize * 1.25,
        vertical: defaultSize * 0.25,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: defaultSize * 13,
          decoration: BoxDecoration(
            color: colorSecondary,
            borderRadius: BorderRadius.circular(defaultRadius),
            image:
                DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultSize * 1.25,
              vertical: defaultSize,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorBlack.withOpacity(0.8),
                  colorBlack.withOpacity(0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConfigText(
                  configFontText: name,
                  configFontWeight: FontWeight.w600,
                  configFontColor: colorBackground,
                  configFontSize: defaultSize * 1.1,
                ),
                const SizedBox(height: defaultSize * 0.2),
                ConfigText(
                  configFontText: time,
                  configFontColor: colorBackground,
                  configFontSize: defaultSize * 0.8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

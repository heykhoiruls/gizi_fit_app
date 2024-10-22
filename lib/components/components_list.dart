import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsList extends StatelessWidget {
  final String? name;
  final String? photo;
  final String? text;
  final Function()? onTap;
  const ComponentsList({
    super.key,
    this.name,
    this.text,
    this.onTap,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultSize),
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
            color: colorSecondary,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultSize * 0.75,
            vertical: defaultSize,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: Image.network(
                        photo ?? imagePhotoBoy,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: defaultSize * 1.25),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConfigText(
                          configFontText: name ?? "No data available",
                          configFontWeight: FontWeight.bold,
                          configFontSize: defaultSize * 0.95,
                        ),
                        const SizedBox(height: defaultSize * 0.25),
                        ConfigText(configFontText: text ?? "No data available"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

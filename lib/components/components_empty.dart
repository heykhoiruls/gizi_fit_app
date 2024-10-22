import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsEmpty extends StatelessWidget {
  final String photo;
  final String text;
  const ComponentsEmpty({
    super.key,
    required this.photo,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: defaultSize * 8),
            SvgPicture.asset(
              photo,
              width: 250.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: defaultSize * 3),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultSize * 1.25,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultSize * 0.75,
                    ),
                    child: ConfigText(
                      configFontText: text,
                    ),
                  ),
                  const SizedBox(height: defaultSize * 4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

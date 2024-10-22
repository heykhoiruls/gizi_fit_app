import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsPhoto extends StatelessWidget {
  final Function()? onTapRight;
  final Function()? onTapLeft;
  final Image? photo;
  final bool isEdit;
  const ComponentsPhoto({
    super.key,
    this.onTapRight,
    this.onTapLeft,
    this.photo,
    this.isEdit = false,
  });

  Widget componentsActionButton(String text, VoidCallback onTap) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize * 1.5,
        vertical: defaultSize,
      ),
      decoration: BoxDecoration(
        color: colorSecondary,
        borderRadius: BorderRadius.circular(defaultRadius * 0.9),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ConfigText(
          configFontText: text,
          configFontColor: colorBlack,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDetail = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: defaultSize * 0.75),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSize),
          child: SizedBox(
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultRadius),
              child: photo,
            ),
          ),
        ),
        isDetail || isEdit
            ? const SizedBox(height: defaultSize * 2.75)
            : const SizedBox.shrink(),
        isDetail || isEdit
            ? Column(
                children: [
                  componentsActionButton("Pilih", onTapRight ?? () {}),
                  const SizedBox(height: defaultSize * 0.7),
                  componentsActionButton("Unggah", onTapLeft ?? () {})
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: defaultSize),
      ],
    );
  }
}

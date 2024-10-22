import 'package:flutter/material.dart';

import '../components/components_decision.dart';
import '../configs/config_apps.dart';
import '../configs/config_components.dart';

void modalBottom(
  BuildContext context,
  String? message,
  String? id,
  Function()? onTap,
) {
  showModalBottomSheet(
    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.01),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: id != null ? 190 : 100,
        decoration: const BoxDecoration(
          color: colorBackground,
        ),
        child: Column(
          mainAxisAlignment:
              id != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            id != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: defaultSize * 0.5,
                          bottom: defaultSize,
                        ),
                        child: Container(
                          height: defaultSize * 0.25,
                          width: defaultSize * 5,
                          decoration: BoxDecoration(
                            color: colorAccent,
                            borderRadius: BorderRadius.circular(
                              defaultRadius,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultSize),
                    ],
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultSize * 2,
              ),
              child: Center(
                child: ConfigText(
                  configFontText: message ?? "",
                  configFontSize: defaultSize * 0.95,
                  configFontWeight: FontWeight.w600,
                ),
              ),
            ),
            id != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultSize * 2,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: defaultSize * 1.25),
                        ComponentsDecision(
                          onTapLeft: () => Navigator.pop(context),
                          onTapRight: onTap,
                          borderRadiusLeft: defaultRadius * 1,
                          borderRadiusRight: defaultRadius * 1,
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    },
  );
}

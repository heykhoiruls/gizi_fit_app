import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsDecision extends StatefulWidget {
  final String? textRight;
  final String? textLeft;
  final Function()? onTapLeft;
  final Function()? onTapRight;
  final double? borderRadiusLeft;
  final double? borderRadiusRight;
  final bool isDifferent;

  const ComponentsDecision({
    Key? key,
    this.textRight,
    this.textLeft,
    this.onTapLeft,
    this.onTapRight,
    this.borderRadiusLeft,
    this.borderRadiusRight,
    this.isDifferent = true,
  }) : super(key: key);

  @override
  State<ComponentsDecision> createState() => _ComponentsDecisionState();
}

class _ComponentsDecisionState extends State<ComponentsDecision> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.onTapLeft ?? () {},
            child: Container(
              decoration: BoxDecoration(
                color: colorAccent,
                border: Border.all(
                  width: 1,
                  color: colorAccent,
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadiusRight ?? defaultRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultSize),
                child: Center(
                  child: ConfigText(
                    configFontText: widget.textLeft ?? "Tidak",
                    configFontColor: colorBlack,
                    configFontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: defaultSize),
        Expanded(
          child: GestureDetector(
            onTap: widget.onTapRight ?? () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: widget.isDifferent ? colorPrimary : colorAccent,
                ),
                color: widget.isDifferent ? colorPrimary : colorAccent,
                borderRadius: BorderRadius.circular(
                  widget.borderRadiusLeft ?? defaultRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultSize),
                child: Center(
                  child: ConfigText(
                    configFontText: widget.textRight ?? "Ya",
                    configFontColor:
                        widget.isDifferent ? colorBackground : colorBlack,
                    configFontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

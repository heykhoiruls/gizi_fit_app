import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsChoice extends StatefulWidget {
  final String? textRight;
  final String? textLeft;
  final Function(bool) onValueChanged;
  final Function()? onTap;
  final Function()? onTapRight;

  const ComponentsChoice({
    Key? key,
    this.textRight,
    this.textLeft,
    required this.onValueChanged,
    this.onTap,
    this.onTapRight,
  }) : super(key: key);

  @override
  State<ComponentsChoice> createState() => _ComponentsChoiceState();
}

class _ComponentsChoiceState extends State<ComponentsChoice> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = false;
                  widget.onValueChanged(isClicked);
                });
              },
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: isClicked ? colorAccent : colorPrimary,
                    ),
                    color: isClicked ? colorAccent : colorPrimary,
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultSize),
                    child: Center(
                      child: ConfigText(
                        configFontText: widget.textLeft ?? "Ya",
                        configFontColor:
                            isClicked ? colorBlack : colorBackground,
                        configFontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: defaultSize),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = true;
                  widget.onValueChanged(isClicked);
                });
              },
              child: GestureDetector(
                onTap: widget.onTapRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: !isClicked ? colorAccent : colorPrimary,
                    border: Border.all(
                      width: 1,
                      color: isClicked ? colorPrimary : colorAccent,
                    ),
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultSize),
                    child: Center(
                      child: ConfigText(
                        configFontText: widget.textRight ?? "Tidak",
                        configFontColor:
                            !isClicked ? colorBlack : colorBackground,
                        configFontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

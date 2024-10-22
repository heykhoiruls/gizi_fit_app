import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';
import '../models/model_list.dart';

class ComponentsSelectGizi extends StatefulWidget {
  final Function(int) onCategorySelected;
  final String text;
  final bool isShowText;

  const ComponentsSelectGizi({
    required this.onCategorySelected,
    required this.text,
    this.isShowText = true,
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentsSelectGizi> createState() => _ComponentsSelectGiziState();
}

class _ComponentsSelectGiziState extends State<ComponentsSelectGizi> {
  ModelList list = ModelList();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultSize * 1.75,
          ),
          child: widget.isShowText
              ? ConfigText(
                  configFontText: widget.text,
                  configFontSize: defaultSize * 0.85,
                  configFontWeight: FontWeight.w600,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: defaultSize * 0.8),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: list.gizi.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    current = index;
                  });
                  widget.onCategorySelected(index);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? defaultSize : defaultSize * 0.5,
                    right:
                        index == list.gizi.length - 1 ? defaultSize * 1.25 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: current == index ? colorPrimary : colorSecondary,
                    border: current == index
                        ? Border.all(
                            color: colorPrimary,
                            width: 1,
                          )
                        : Border.all(
                            color: colorSecondary,
                            width: 1,
                          ),
                    borderRadius: BorderRadius.circular(
                      defaultRadius * 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      ConfigText(
                        configFontText: list.gizi[index],
                        configFontColor:
                            current == index ? colorBackground : colorBlack,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        widget.isShowText
            ? const SizedBox(height: defaultSize * 1.2)
            : const SizedBox.shrink(),
      ],
    );
  }
}

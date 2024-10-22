import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';
import '../models/model_list.dart';

class ComponentsCategory extends StatefulWidget {
  final Function(int) onCategorySelected;
  final String text;
  final bool isShowText;

  const ComponentsCategory({
    required this.onCategorySelected,
    required this.text,
    this.isShowText = true,
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentsCategory> createState() => _ComponentsCategoryState();
}

class _ComponentsCategoryState extends State<ComponentsCategory> {
  ModelList list = ModelList();
  int current = 0;

  String _getText(int index) {
    switch (widget.text) {
      case 'Peran':
        return list.role[index];
      case 'Jenis Kelamin':
        return list.gender[index];
      case 'Gizi':
        return list.gizi[index];
      default:
        return '';
    }
  }

  int _getLength() {
    switch (widget.text) {
      case 'Peran':
        return list.role.length;
      case 'Jenis Kelamin':
        return list.gender.length;
      case 'Gizi':
        return list.gizi.length;
      default:
        return 0;
    }
  }

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
          height: 50,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _getLength(),
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
                    left: index == 0 ? defaultSize * 1.25 : defaultSize * 0.85,
                    right: index == _getLength() - 1 ? defaultSize * 1.25 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: current == index ? colorPrimary : colorAccent,
                    border: current == index
                        ? Border.all(
                            color: colorPrimary,
                            width: 1,
                          )
                        : Border.all(
                            color: colorBlack,
                            width: 1,
                          ),
                    borderRadius: BorderRadius.circular(
                      defaultRadius * 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      ConfigText(
                        configFontText: _getText(index),
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

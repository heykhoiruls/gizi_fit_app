// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gizi_fit_app/configs/config_components.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/config_apps.dart';

class ComponentsCategoryRecomendation extends StatefulWidget {
  final Function(String) onCategorySelected;

  const ComponentsCategoryRecomendation({
    required this.onCategorySelected,
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentsCategoryRecomendation> createState() =>
      _ComponentsCategoryRecomendationState();
}

class _ComponentsCategoryRecomendationState
    extends State<ComponentsCategoryRecomendation> {
  int current = -1;

  late List<String> shuffledFood;

  @override
  void initState() {
    super.initState();
    shuffledFood = List.from(list.food)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSize * 1.5),
          child: Text(
            "Saran makanan",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultSize),
          child: SizedBox(
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    widget.onCategorySelected(shuffledFood[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? defaultSize : defaultSize * 0.5,
                      right: index == 6 - 1 ? defaultSize : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: defaultSize),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ConfigText(
                          configFontText: shuffledFood[index],
                          configFontColor:
                              current == index ? colorBackground : colorBlack,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gizi_fit_app/components/components_button.dart';
import 'package:gizi_fit_app/components/components_header.dart';
import 'package:gizi_fit_app/components/components_transition.dart';
import 'package:gizi_fit_app/configs/config_apps.dart';
import 'package:gizi_fit_app/pages/page_kids/page_kids.dart';
import '../../components/components_growth_card.dart';
import '../../configs/config_components.dart';
import '../../models/model_nutrition.dart';

class PageDetailChooseNutrition extends StatefulWidget {
  final Nutrition recipe;
  final String id;

  PageDetailChooseNutrition({
    required this.id,
    required this.recipe,
  });

  @override
  State<PageDetailChooseNutrition> createState() =>
      _PageDetailChooseNutritionState();
}

class _PageDetailChooseNutritionState extends State<PageDetailChooseNutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsHeader(text: "Detail Menu"),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: defaultSize,
                    left: defaultSize,
                    bottom: defaultSize,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 350,
                        margin: const EdgeInsets.only(
                          bottom: defaultSize,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          image: DecorationImage(
                            image: NetworkImage(widget.recipe.photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultSize,
                        ),
                        child: ConfigText(
                          configFontText: widget.recipe.text,
                          configFontSize: defaultSize * 1.25,
                          configFontWeight: FontWeight.w600,
                        ),
                      ),
                      ComponentsGrowthCard(
                        isShowDate: false,
                        protein: widget.recipe.protein,
                        lemak: widget.recipe.lemak,
                        air: widget.recipe.air,
                        karbohidrat: widget.recipe.karbohidrat,
                        serat: widget.recipe.serat,
                        kalori: widget.recipe.kalori,
                      ),
                      SizedBox(height: defaultSize * 4),
                      ComponentsButton(
                        text: "Tambahkan Menu",
                        color: colorBackground,
                        onTap: () {
                          Nutrition nutrition = Nutrition(
                            protein: widget.recipe.protein,
                            lemak: widget.recipe.lemak,
                            air: widget.recipe.air,
                            karbohidrat: widget.recipe.karbohidrat,
                            serat: widget.recipe.serat,
                            kalori: widget.recipe.kalori,
                            text: widget.recipe.text,
                            photo: widget.recipe.photo,
                          );
                          controllerGrowth.add(widget.id, nutrition);
                          Navigator.push(
                            context,
                            transitionRight(
                              PageKids(id: widget.id),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: defaultSize)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

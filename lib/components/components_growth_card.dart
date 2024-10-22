// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsGrowthCard extends StatefulWidget {
  final double kalori;
  final double karbohidrat;
  final double serat;
  final double air;
  final double lemak;
  final double protein;
  final double? totalNutrition;
  final String? date;
  final String? age;
  final Function()? onTap;
  final Function()? onLongTap;
  final bool isShowDate;
  const ComponentsGrowthCard({
    super.key,
    required this.kalori,
    required this.karbohidrat,
    required this.serat,
    required this.air,
    required this.lemak,
    required this.protein,
    this.totalNutrition,
    this.date,
    this.age,
    this.onTap,
    this.onLongTap,
    this.isShowDate = true,
  });

  @override
  State<ComponentsGrowthCard> createState() => _ComponentsGrowthCardState();
}

class _ComponentsGrowthCardState extends State<ComponentsGrowthCard> {
  String? role;

  @override
  void initState() {
    super.initState();
    userRole();
  }

  Widget textNutrition(String type, double value, String unit) {
    return Expanded(
      child: Column(
        children: [
          ConfigText(
            configFontText: type,
            configFontColor: colorBackground,
          ),
          const SizedBox(height: defaultSize * 0.25),
          ConfigText(
            configFontText: '${value.toStringAsFixed(1)} $unit',
            configFontColor: colorBackground,
            configFontSize: defaultSize,
            configFontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Future<void> userRole() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      final data = user.data() as Map<String, dynamic>;

      setState(() {
        role = data['role'];
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  String bodyMassIndex() {
    double value = widget.totalNutrition ?? 0;

    if (value < 5000.5) {
      return 'Gizi Kurang';
    } else if (value >= 5000.5 && value < 10000) {
      return 'Gizi Normal';
    } else {
      return 'Gizi Berlebih';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSize * 1.25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isShowDate
                    ? ConfigText(
                        configFontText: widget.date ?? "No data available",
                        configFontSize: defaultSize * 0.8,
                        configFontWeight: FontWeight.bold,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultSize),
        GestureDetector(
          onTap: widget.onTap,
          onLongPress:
              (role != null && role != 'Orang Tua') ? widget.onLongTap : () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSize * 0.25),
            child: Container(
              padding: const EdgeInsets.only(
                top: defaultSize * 1.5,
                bottom: defaultSize * 2,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: colorPrimary,
                boxShadow: [defaultShadow],
              ),
              child: Column(
                children: [
                  widget.isShowDate
                      ? Column(
                          children: [
                            ConfigText(
                              configFontText: bodyMassIndex(),
                              configFontSize: defaultSize * 1.1,
                              configFontWeight: FontWeight.bold,
                              configFontColor: colorBackground,
                            ),
                            const SizedBox(height: defaultSize * 0.75),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      textNutrition('Air', widget.air, "g"),
                      textNutrition('Karbohidrat', widget.karbohidrat, "g"),
                      textNutrition('Serat', widget.serat, "g"),
                    ],
                  ),
                  const SizedBox(height: defaultSize * 1.5),
                  Row(
                    children: [
                      textNutrition('Lemak', widget.lemak, "g"),
                      textNutrition('Kalori', widget.kalori, "kcal"),
                      textNutrition('Protein', widget.protein, "g"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: defaultSize * 0.75),
      ],
    );
  }
}

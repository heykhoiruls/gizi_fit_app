import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure Firestore is imported
import 'package:gizi_fit_app/components/components_growth_card.dart';

import '../../components/components_header.dart';
import '../../configs/config_apps.dart';
import '../../configs/config_components.dart';

class PageDetailNutrition extends StatefulWidget {
  final String id;
  const PageDetailNutrition({
    required this.id,
    super.key,
  });

  @override
  State<PageDetailNutrition> createState() => _PageDetailNutritionState();
}

class _PageDetailNutritionState extends State<PageDetailNutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: controllerGrowth.streamsGrowth.doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text(widget.id));
            }

            var data = snapshot.data!.data() as Map<String, dynamic>?;

            if (data == null) {
              return Center(child: Text(widget.id));
            }

            double doubleParse(Map<String, dynamic> data, String key) {
              if (data[key] != null) {
                return double.tryParse(data[key].toString()) ?? 0;
              }
              return 0;
            }

            return Column(
              children: [
                const ComponentsHeader(text: "Detail Nutrisi"),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
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
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              image: DecorationImage(
                                image: NetworkImage(data['photo'] ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultSize),
                            child: ConfigText(
                              configFontText: data['name'] ?? '',
                              configFontSize: defaultSize * 1.25,
                              configFontWeight: FontWeight.w600,
                            ),
                          ),
                          ComponentsGrowthCard(
                            isShowDate: false,
                            protein: doubleParse(data, 'protein'),
                            lemak: doubleParse(data, 'lemak'),
                            air: doubleParse(data, 'air'),
                            karbohidrat: doubleParse(data, 'karbohidrat'),
                            serat: doubleParse(data, 'serat'),
                            kalori: doubleParse(data, 'kalori'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

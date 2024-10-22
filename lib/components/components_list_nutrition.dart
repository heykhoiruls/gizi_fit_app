import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';
import '../pages/page_kids/page_detail_nutrition.dart';
import 'components_nutrition.dart';
import 'components_transition.dart';

class ComponentsListNutrition extends StatelessWidget {
  final String id;
  const ComponentsListNutrition({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: controllerGrowth.streamsGrowth
            .where("id_total", isEqualTo: id)
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          }
          var data = snapshot.data!;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final item = data.docs[index];
              var timestamp = (item['timestamp'] as Timestamp).toDate();
              var formattedDate =
                  DateFormat('EEEE, dd MMMM yyyy').format(timestamp);
              var formattedTime = DateFormat('HH : mm').format(timestamp);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultSize * 2,
                        right: defaultSize * 2,
                        bottom: defaultSize,
                      ),
                      child: ConfigText(
                        configFontText: formattedDate,
                        configFontWeight: FontWeight.w600,
                      ),
                    ),
                  ComponentsNutrition(
                    onTap: () {
                      Navigator.push(
                        context,
                        transitionRight(
                          PageDetailNutrition(
                            id: item['id'],
                          ),
                        ),
                      );
                    },
                    name: item['name'] ?? 'No data available.',
                    time: formattedTime,
                    photo: item['photo'] ?? 'No data available.',
                  ),
                  if (index == data.size - 1)
                    const SizedBox(
                      height: defaultSize,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

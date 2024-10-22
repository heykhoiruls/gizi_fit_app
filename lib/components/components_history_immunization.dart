import '../configs/config_apps.dart';
import 'package:flutter/material.dart';
import 'components_immunization.dart';
import '../configs/config_components.dart';

class ComponentsHistoryImmunization extends StatelessWidget {
  final String id;
  const ComponentsHistoryImmunization({
    required this.id,
    super.key,
  });

  List buildImmunization(Map<String, dynamic> snapdata) {
    final excludeKeys = ['uid', 'timestamp'];

    List immunizations = snapdata.entries
        .where((entry) => !excludeKeys.contains(entry.key))
        .map((entry) {
      return ComponentsImmunization(
        id: id,
        text: entry.key,
        isClicked: entry.value,
        isClickedFunction: () {
          controllerImmun.streamsImmunization.doc(id).update({
            entry.key: !entry.value,
          });
        },
      );
    }).toList();

    immunizations.sort((a, b) => a.text.compareTo(b.text));

    return immunizations;
  }

  buildImmun(BuildContext context, Map<String, dynamic> snapdata) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultSize),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: colorAccent,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(defaultSize * 0.5),
              child: Column(
                children: [
                  if (snapdata.isNotEmpty) ...[
                    const Column(
                      children: [
                        SizedBox(height: defaultSize),
                        ConfigText(
                          configFontText: "Riwayat Imunisasi",
                          configFontSize: defaultSize,
                          configFontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: defaultSize * 1.5),
                      ],
                    ),
                    const SizedBox(height: defaultSize),
                    ...buildImmunization(snapdata),
                    const SizedBox(height: defaultSize * 10),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerImmun.streamsImmunization.doc(id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        return buildImmun(context, data);
      },
    );
  }
}

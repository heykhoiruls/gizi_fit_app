import '../components/components_decision.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/config_apps.dart';
import 'package:flutter/material.dart';

modalChoice(BuildContext context, String field, Function(String) callback) {
  String valueNew = "";

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      elevation: 1,
      child: Container(
        width: 900,
        padding: const EdgeInsets.all(defaultSize),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: defaultSize * 0.5),
                child: Text(
                  field,
                  style: GoogleFonts.poppins(
                    fontSize: defaultSize * 0.85,
                    color: colorBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultSize),
            ComponentsDecision(
              isDifferent: false,
              textLeft: "Laki Laki",
              textRight: "Perempuan",
              onTapLeft: () {
                valueNew = 'Laki Laki';
                callback(valueNew);
                Navigator.of(context).pop();
              },
              onTapRight: () {
                valueNew = 'Perempuan';
                callback(valueNew);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';

class ComponentsChatBubble extends StatelessWidget {
  final String message;
  final Color? colorContainer;
  final Color? colorText;
  final String date;
  final Color? colorDate;
  final CrossAxisAlignment crossAlignment;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const ComponentsChatBubble({
    required this.colorContainer,
    required this.colorText,
    required this.message,
    required this.date,
    required this.colorDate,
    required this.crossAlignment,
    required this.borderRadiusGeometry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      padding: const EdgeInsets.symmetric(
        vertical: defaultSize,
        horizontal: defaultSize * 1.25,
      ), // Adjust as needed
      decoration: BoxDecoration(
        borderRadius: borderRadiusGeometry,
        color: colorContainer,
      ),
      child: Column(
        crossAxisAlignment: crossAlignment,
        children: [
          Text(
            message,
            style: GoogleFonts.poppins(
              color: colorText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

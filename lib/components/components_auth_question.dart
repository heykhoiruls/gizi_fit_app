import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';

class ComponentsAuthQuestion extends StatelessWidget {
  final String textQuestion;
  final String textStatement;
  final Function()? onTap;

  const ComponentsAuthQuestion({
    super.key,
    required this.textQuestion,
    required this.textStatement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: textQuestion,
            style: GoogleFonts.poppins(
              color: colorBlack,
            ),
          ),
          TextSpan(
            text: textStatement,
            style: GoogleFonts.poppins(
              color: colorBlack,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

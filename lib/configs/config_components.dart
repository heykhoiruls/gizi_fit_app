import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'config_apps.dart';

class ConfigText extends StatelessWidget {
  final String configFontText;
  final double? configFontSize;
  final FontWeight? configFontWeight;
  final Color? configFontColor;
  const ConfigText({
    super.key,
    required this.configFontText,
    this.configFontSize,
    this.configFontWeight,
    this.configFontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      configFontText,
      style: GoogleFonts.poppins(
        fontSize: configFontSize,
        fontWeight: configFontWeight,
        color: configFontColor ?? colorBlack,
      ),
    );
  }
}

// function
void Function(BuildContext)? popContext = (context) {
  Navigator.pop(context);
};

class LineDeviderVertical extends StatelessWidget {
  final double lineHeight;
  final Color? colorChoose;
  const LineDeviderVertical({
    required this.lineHeight,
    this.colorChoose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: lineHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: colorChoose ?? colorBackground,
      ),
    );
  }
}

class LineDeviderHorizontal extends StatelessWidget {
  final double lineWidth;
  final Color? colorChoose;
  const LineDeviderHorizontal({
    required this.lineWidth,
    this.colorChoose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: lineWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: colorChoose ?? colorBackground,
      ),
    );
  }
}

final kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultRadius),
  borderSide: const BorderSide(
    color: colorPrimary,
  ),
);

final eInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultRadius),
  borderSide: const BorderSide(
    color: colorRed,
  ),
);

final sInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(defaultRadius),
  borderSide: const BorderSide(
    color: colorBlack,
  ),
);

final defaultShadow = BoxShadow(
  color: colorBlack.withOpacity(0.2),
  blurRadius: 10,
  offset: const Offset(0, 4),
);

String formatDate(Timestamp initialDate) {
  DateTime date = initialDate.toDate();
  String formattedDate = DateFormat('dd MMMM yyyy').format(date);
  return formattedDate;
}

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}

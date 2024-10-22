// ignore_for_file: file_names

import '../configs/config_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget setBottomTitle(
  double value,
  TitleMeta meta,
  String id,
) {
  var style = const TextStyle(
    color: colorBlack,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  int intValue = value.toInt();

  Widget text = Text(
    '$intValue',
    style: style,
  );

  switch (value.toInt()) {
    default:
      text;
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

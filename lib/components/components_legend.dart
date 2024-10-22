import 'package:flutter/material.dart';
import 'package:gizi_fit_app/components/components_date_picker.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsLegend extends StatefulWidget {
  final Function(List<DateTime?>) onDatesChanged;
  const ComponentsLegend({
    required this.onDatesChanged,
    super.key,
  });

  @override
  State<ComponentsLegend> createState() => _ComponentsLegendState();
}

class _ComponentsLegendState extends State<ComponentsLegend> {
  List<DateTime?> _dates = [];
  void _updateSelectedDates(List<DateTime?> dates) {
    setState(() {
      _dates = dates;
      widget.onDatesChanged(_dates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultSize),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ComponentsDatePicker(
                onDatesChanged: _updateSelectedDates,
              ),
              Row(
                children: [
                  Container(
                    height: defaultSize * 0.75,
                    width: 40,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  const SizedBox(
                    width: defaultSize,
                  ),
                  const ConfigText(
                    configFontText: "Total Gizi",
                    configFontSize: defaultSize * 0.8,
                    configFontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

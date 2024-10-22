import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gizi_fit_app/configs/config_apps.dart';
import 'package:gizi_fit_app/configs/config_components.dart';

class ComponentsDatePicker extends StatefulWidget {
  final Function(List<DateTime?>) onDatesChanged;
  const ComponentsDatePicker({
    required this.onDatesChanged,
    super.key,
  });

  @override
  State<ComponentsDatePicker> createState() => _ComponentsDatePickerState();
}

List<DateTime?> _dates = [];

class _ComponentsDatePickerState extends State<ComponentsDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _dates.isEmpty
              ? () {
                  List<DateTime?> tempDates = List.from(_dates);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: colorBackground,
                        backgroundColor: colorBackground,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: defaultSize * 0.5,
                          vertical: defaultSize,
                        ),
                        content: Container(
                          color: colorBackground,
                          width: MediaQuery.of(context).size.width *
                              1.5, // Adjust dialog width as needed
                          child: CalendarDatePicker2(
                            config: CalendarDatePicker2Config(
                              selectedDayHighlightColor: colorPrimary,
                              selectedRangeHighlightColor: colorSecondary,
                              daySplashColor: Colors.transparent,
                              calendarType: CalendarDatePicker2Type.range,
                              lastDate: DateTime.now(),
                            ),
                            value: tempDates,
                            onValueChanged: (dates) {
                              tempDates = dates;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const ConfigText(configFontText: "Batal"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              color: colorPrimary,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultSize * 0.2,
                              vertical: defaultSize * 0.1,
                            ),
                            child: TextButton(
                              child: const ConfigText(
                                configFontText: "Pilih",
                                configFontColor: colorBackground,
                              ),
                              onPressed: () {
                                setState(() {
                                  _dates = tempDates;
                                  widget.onDatesChanged(_dates);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              : () {
                  setState(() {
                    _dates = [];
                    widget.onDatesChanged(_dates);
                  });
                },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
                color: colorSecondary,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: defaultSize * 1.25,
                vertical: defaultSize * 0.5,
              ),
              child: ConfigText(
                configFontText:
                    _dates.isEmpty ? "Pilih tanggal" : "Hapus range",
                configFontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
}

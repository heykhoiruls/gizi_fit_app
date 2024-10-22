// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gizi_fit_app/components/components_button.dart';
import 'package:gizi_fit_app/components/components_transition.dart';
import 'package:intl/intl.dart';

import '../components/components_growth_card.dart';
import '../configs/config_components.dart';
import '../pages/page_kids/page_nutrition.dart';
import 'components_modal_bottom.dart';
import 'components_growth_chart.dart';
import '../configs/config_apps.dart';
import 'components_legend.dart';
import 'components_empty.dart';

class ComponentsHistoryGrowth extends StatefulWidget {
  final String id;
  const ComponentsHistoryGrowth({
    super.key,
    required this.id,
  });

  @override
  State<ComponentsHistoryGrowth> createState() =>
      _ComponentsHistoryGrowthState();
}

class _ComponentsHistoryGrowthState extends State<ComponentsHistoryGrowth> {
  List<DateTime?> _dates = [];
  String? role;

  @override
  void initState() {
    super.initState();
    userRole();
  }

  void _updateSelectedDates(List<DateTime?> dates) {
    setState(() {
      _dates = dates;
    });
  }

  Future<void> userRole() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      final data = user.data() as Map<String, dynamic>;

      setState(() {
        role = data['role'];
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  List<DocumentSnapshot> _filterDataByDateRange(QuerySnapshot snapshot) {
    List<DocumentSnapshot> filteredData = [];

    if (_dates.isEmpty) {
      return snapshot.docs;
    }

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DateTime timestamp = (data['timestamp'] as Timestamp).toDate();

      if (_dates.length == 1 && _dates[0] != null) {
        DateTime selectedDate = _dates[0]!;
        if (_isSameDay(timestamp, selectedDate)) {
          filteredData.add(doc);
        }
      } else if (_dates.length == 2 && _dates[0] != null && _dates[1] != null) {
        DateTime startDate = _dates[0]!;
        DateTime endDate = _dates[1]!.add(const Duration(days: 1));
        if (timestamp.isAfter(startDate.subtract(const Duration(days: 1))) &&
            timestamp.isBefore(endDate)) {
          filteredData.add(doc);
        }
      }
    }

    return filteredData;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<Map<String, dynamic>> getKidsData(String id) async {
    try {
      CollectionReference kidsCollection = controllerUser.streamUsers;

      QuerySnapshot kidsQuerySnapshot = await kidsCollection
          .where(
            'uid',
            isEqualTo: id,
          )
          .get();

      Map<String, dynamic> kidsData = {};
      for (var doc in kidsQuerySnapshot.docs) {
        kidsData[doc.id] = doc.data();
      }

      return kidsData;
    } catch (e) {
      return {};
    }
  }

  Widget buildGrowth(
    BuildContext context,
    QuerySnapshot snapdata,
    Map<String, dynamic> kidsData,
  ) {
    List<DocumentSnapshot> filteredData = _filterDataByDateRange(snapdata);
    if (filteredData.isEmpty) {
      return SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSize),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: defaultSize * 2),
                const ConfigText(
                  configFontText: "No records found for selected date or range",
                ),
                const SizedBox(height: defaultSize * 2),
                ComponentsButton(
                  onTap: () {
                    setState(() {
                      _updateSelectedDates([]);
                    });
                  },
                  text: "Kembali",
                  color: colorBackground,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultSize,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: colorAccent,
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              var data = filteredData[index].data() as Map<String, dynamic>;

              var formattedDate = DateFormat('EEE, dd MMMM yyyy').format(
                data['timestamp'].toDate(),
              );

              DateTime birthDate = kidsData[widget.id]['birthDate'].toDate();

              int calAgeInMonths(DateTime birthDate) {
                final currentDate = data['timestamp'].toDate();
                final age = currentDate.difference(birthDate);
                final ageInMonths = age.inDays ~/ 30;
                return ageInMonths;
              }

              int ageInMonths = calAgeInMonths(birthDate);

              List<double> dataNutrition = [];

              for (var doc in snapdata.docs.reversed) {
                var data = doc.data() as Map<String, dynamic>;
                if (data.containsKey('totalNutrition')) {
                  dataNutrition.add(
                    double.parse(
                      data['totalNutrition'].toString(),
                    ),
                  );
                }
              }

              return Padding(
                padding: const EdgeInsets.all(defaultSize * 0.5),
                child: Column(
                  children: [
                    if (index == 0)
                      Column(
                        children: [
                          const ConfigText(
                            configFontText: "Riwayat Gizi",
                            configFontSize: defaultSize,
                            configFontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: defaultSize * 1.5),
                          ComponentsGrowthChart(
                            id: widget.id,
                            totalNutrition: dataNutrition,
                            ageInMonths: ageInMonths,
                          ),
                          const SizedBox(height: defaultSize),
                          ComponentsLegend(
                            onDatesChanged: _updateSelectedDates,
                          ),
                          const SizedBox(height: defaultSize),
                        ],
                      ),
                    ComponentsGrowthCard(
                      totalNutrition:
                          double.parse(data['totalNutrition'].toString()),
                      protein: double.parse(data['protein'].toString()),
                      lemak: double.parse(data['lemak'].toString()),
                      air: double.parse(data['air'].toString()),
                      karbohidrat: double.parse(data['karbohidrat'].toString()),
                      serat: double.parse(data['serat'].toString()),
                      kalori: double.parse(data['kalori'].toString()),
                      date: formattedDate,
                      age: "$ageInMonths Bulan",
                      onTap: () {
                        Navigator.push(
                          context,
                          transitionRight(
                            PageNutrition(id: data['id_total']),
                          ),
                        );
                      },
                      onLongTap: () {
                        modalBottom(
                          context,
                          messageDeleteRecords,
                          '90',
                          () {
                            controllerGrowth.deleteNutrition(
                              snapdata.docs[index].id,
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                    if (index == snapdata.size - 1)
                      const SizedBox(
                        height: defaultSize * 6,
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerGrowth.streamsTotal
          .where("id_user", isEqualTo: widget.id)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasData) {
          var data = snapshot.data as QuerySnapshot;
          if (data.docs.isNotEmpty) {
            return FutureBuilder(
              future: getKidsData(widget.id),
              builder:
                  (context, AsyncSnapshot<Map<String, dynamic>> kidsSnapshot) {
                if (kidsSnapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (kidsSnapshot.hasData) {
                  return buildGrowth(context, data, kidsSnapshot.data!);
                } else {
                  return const ComponentsEmpty(
                    photo: imagePageKidsEmpty,
                    text: messageDefault,
                  );
                }
              },
            );
          } else {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultSize),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    color: colorAccent,
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      ComponentsEmpty(
                        photo: imagePageKidsEmpty,
                        text: (role != "Orang Tua")
                            ? messageKidsDataEmptyForOthers
                            : messageKidsDataEmptyForParent,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return ComponentsEmpty(
            photo: imagePageKidsEmpty,
            text: (role != "Orang Tua")
                ? messageKidsDataEmptyForOthers
                : messageKidsDataEmptyForParent,
          );
        }
      },
    );
  }
}

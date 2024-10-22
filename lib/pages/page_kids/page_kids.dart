// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gizi_fit_app/components/components_transition.dart';
import 'package:gizi_fit_app/pages/page_first.dart';
import 'package:gizi_fit_app/pages/page_kids/page_kids_detail.dart';

import '../../components/components_floating.dart';
import '../../components/components_growth.dart';
import '../../components/components_header.dart';
import '../../components/components_list.dart';
import '../../configs/config_apps.dart';

class PageKids extends StatefulWidget {
  final String id;
  const PageKids({
    super.key,
    required this.id,
  });

  @override
  State<PageKids> createState() => _PageKidsState();
}

class _PageKidsState extends State<PageKids> {
  bool isClicked = false;
  String? role;

  @override
  void initState() {
    super.initState();
    userRole();
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerUser.streamUsers.doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.data() == null) {
          return const Scaffold(
            backgroundColor: colorBackground,
            body: SizedBox.shrink(),
          );
        }
        if (snapshot.hasData) {
          var data = snapshot.data!.data() as Map<String, dynamic>;

          int daysInMonth(int year, int month) {
            return DateTime(year, month + 1, 0).day;
          }

          String calAge(DateTime birthDate) {
            final currentDate = DateTime.now();
            int years = currentDate.year - birthDate.year;
            int months = currentDate.month - birthDate.month;
            int remainingDays = currentDate.day - birthDate.day;

            if (months < 0 || (months == 0 && remainingDays < 0)) {
              years--;
              months += 12;
            }
            if (remainingDays < 0) {
              months--;
              int daysInPrevMonth =
                  daysInMonth(currentDate.year, currentDate.month - 1);
              remainingDays += daysInPrevMonth;
            }

            String ageString = '$years tahun';
            if (months > 0) {
              ageString += ' $months bulan';
            }
            return ageString;
          }

          DateTime birthDate = data['birthDate'].toDate();
          String age = calAge(birthDate);

          return Scaffold(
            backgroundColor: colorBackground,
            floatingActionButton: Stack(
              children: [
                (role != null && role != 'Orang Tua')
                    ? Positioned(
                        bottom: defaultSize * 0.05,
                        right: defaultSize * 0.75,
                        child: ComponentsFloating(
                          id: widget.id,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  ComponentsHeader(
                    text: "Data anak",
                    id: widget.id,
                    isKidPage: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        transitionLeft(
                          const PageFirst(),
                        ),
                      );
                    },
                  ),
                  ComponentsList(
                    photo: data['photo'],
                    name: data['name'],
                    text: "$age, ${data['gender']}",
                    onTap: () {
                      Navigator.push(
                        context,
                        transitionLeft(
                          PageKidsDetail(id: widget.id),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: defaultSize),
                  ComponentsHistoryGrowth(id: widget.id)
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

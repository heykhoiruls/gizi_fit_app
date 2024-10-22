// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icon.dart';
import 'package:flutter/material.dart';

import '../configs/config_components.dart';
import '../configs/config_apps.dart';

class ComponentsImmunization extends StatefulWidget {
  final String id;
  final String text;
  final bool? isClicked;
  final Function() isClickedFunction;

  const ComponentsImmunization({
    Key? key,
    required this.id,
    required this.text,
    this.isClicked,
    required this.isClickedFunction,
  }) : super(key: key);

  @override
  State<ComponentsImmunization> createState() => _ComponentsImmunizationState();
}

class _ComponentsImmunizationState extends State<ComponentsImmunization> {
  late bool isClicked;
  String? role;

  @override
  void initState() {
    super.initState();
    isClicked = widget.isClicked ?? true;
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
    return Padding(
      padding: const EdgeInsets.only(
        left: defaultSize * 0.5,
        right: defaultSize * 0.5,
        bottom: defaultSize * 1.5,
      ),
      child: Container(
        width: double.infinity,
        height: defaultSize * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: [defaultShadow],
          color: colorAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConfigText(
                configFontText: widget.text,
                configFontWeight: FontWeight.bold,
              ),
              GestureDetector(
                onTap: (role != null && role == "Bidan Posyandu")
                    ? () {
                        setState(() {
                          isClicked = !isClicked;
                          widget.isClickedFunction();
                        });
                      }
                    : () {},
                child: isClicked
                    ? Container(
                        height: defaultSize * 2.5,
                        width: defaultSize * 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(defaultRadius * 2),
                          color: colorPrimary,
                        ),
                        child: const LineIcon.check(
                          color: colorBackground,
                        ))
                    : Container(
                        height: defaultSize * 2.5,
                        width: defaultSize * 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(defaultRadius * 2),
                          color: colorBackground,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../components/components_icon.dart';
import '../configs/config_apps.dart';
import 'components_menu.dart';

class ComponentsHeader extends StatefulWidget {
  final String? id;
  final Function()? onTap;

  final String text;
  final bool isKidPage;

  const ComponentsHeader({
    super.key,
    this.id,
    this.onTap,
    required this.text,
    this.isKidPage = false,
  });

  @override
  State<ComponentsHeader> createState() => _ComponentsHeaderState();
}

class _ComponentsHeaderState extends State<ComponentsHeader> {
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
    return Padding(
      padding: const EdgeInsets.all(defaultSize),
      child: Row(
        children: [
          ComponentsIcon(
            onTap: widget.onTap ??
                () {
                  Navigator.pop(context);
                },
          ),
          const SizedBox(width: defaultSize),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: defaultSize * 3,
                decoration: BoxDecoration(
                  color: colorBackground,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultSize,
                  ),
                  child: Center(
                    child: Text(
                      widget.text,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultSize,
                        color: colorBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          (role != null && (role == 'Orang Tua' && widget.isKidPage))
              ? const SizedBox(width: defaultSize)
              : const SizedBox.shrink(),
          (role != null && (role == 'Orang Tua' && widget.isKidPage))
              ? ComponentsMenu(id: widget.id ?? '')
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

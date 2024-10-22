// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icon.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import 'components_input_text.dart';
import 'components_icon.dart';

class ComponentsRow extends StatefulWidget {
  final LineIcon? icon;
  final Function()? onTap;
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onSearchTextChanged;
  final TextEditingController? controller;
  final String? textHint;
  final bool isParent;
  final bool isChat;

  const ComponentsRow({
    Key? key,
    this.icon,
    this.onTap,
    this.onFocusChange,
    this.controller,
    this.textHint,
    this.onSearchTextChanged,
    this.isParent = false,
    this.isChat = true,
  }) : super(key: key);

  @override
  State<ComponentsRow> createState() => _ComponentsRowState();
}

class _ComponentsRowState extends State<ComponentsRow> {
  bool _isFocused = false;
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
      padding: const EdgeInsets.symmetric(horizontal: defaultSize),
      child: Row(
        children: [
          ComponentsInputText(
            textHint: widget.textHint ?? 'This a controller',
            controller: widget.controller,
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
              widget.onFocusChange?.call(_isFocused);
            },
            onSearch: (text) {
              widget.onSearchTextChanged?.call(text);
            },
          ),
          role != null && (role == 'Orang Tua' || widget.isChat)
              ? const SizedBox(width: defaultSize)
              : const SizedBox.shrink(),
          role != null && (role == 'Orang Tua' || widget.isChat)
              ? ComponentsIcon(
                  icon: widget.icon,
                  onTap: widget.onTap ?? () {},
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

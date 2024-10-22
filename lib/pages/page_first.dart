import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../models/model_list.dart';
import '../configs/config_apps.dart';
import '../pages/page_chat.dart';
import '../pages/page_home.dart';
import '../pages/page_profile.dart';

class PageFirst extends StatefulWidget {
  const PageFirst({super.key});

  @override
  State<PageFirst> createState() => _PageFirstState();
}

class _PageFirstState extends State<PageFirst> {
  ModelList list = ModelList();
  int selectedIndex = 0;
  bool _isHomeFocused = true;

  void handleFocusChange(bool isFocused) {
    setState(() {
      _isHomeFocused = !isFocused;
    });
  }

  void navigationBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> pages = [
      PageHome(
        onFocusChange: handleFocusChange,
      ),
      const PageChat(),
      const PageProfile(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: _isHomeFocused
          ? NavigationBar(
              backgroundColor: colorBackground,
              indicatorColor: colorSecondary,
              elevation: 0,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => navigationBar(index),
              destinations: const [
                NavigationDestination(
                  icon: LineIcon.home(),
                  label: "Beranda",
                ),
                NavigationDestination(
                  icon: LineIcon.whatSApp(),
                  label: "Pesan",
                ),
                NavigationDestination(
                  icon: LineIcon.user(),
                  label: "Profile",
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

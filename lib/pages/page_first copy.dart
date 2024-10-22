import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
      const PageProfile()
    ];
    return Scaffold(
      body: pages[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _isHomeFocused
          ? Container(
              decoration: const BoxDecoration(
                color: colorPrimary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSize * 1.5,
                  vertical: defaultSize * 1.25,
                ),
                child: GNav(
                  selectedIndex: selectedIndex,
                  rippleColor: colorPrimary,
                  hoverColor: colorPrimary,
                  haptic: true,
                  tabBorderRadius: defaultSize * 4,
                  onTabChange: navigationBar,
                  gap: 8,
                  color: colorBackground,
                  activeColor: colorPrimary,
                  iconSize: 24,
                  tabBackgroundColor: colorBackground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultSize * 1,
                    vertical: defaultSize * 0.75,
                  ),
                  tabs: const [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.whatSApp,
                      text: 'Chat',
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

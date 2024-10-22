import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../components/components_title_page.dart';
import '../components/components_select_gizi.dart';
import '../components/components_transition.dart';
import '../components/components_list_kids.dart';
import '../components/components_row.dart';
import '../configs/config_apps.dart';
import '../models/model_controller.dart';
import 'page_kids/page_kids_add.dart';

class PageHome extends StatefulWidget {
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<String>? onSearchTextChanged;
  const PageHome({
    super.key,
    this.onFocusChange,
    this.onSearchTextChanged,
  });

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String _searchText = '';
  ModelController user = ModelController();
  int selectedGiziIndex = 0;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
          const ComponentsTitlePage(
            title: "Halaman Beranda",
          ),
          const SizedBox(height: defaultSize * 0.75),
          ComponentsRow(
            textHint: "Cari nama anak . . .",
            icon: const LineIcon.equals(color: colorBlack),
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
              widget.onFocusChange?.call(_isFocused);
            },
            onTap: () {
              Navigator.push(
                context,
                transitionRight(const PageKidsAdd()),
              );
            },
            onSearchTextChanged: (text) {
              setState(() {
                _searchText = text;
              });
            },
            isChat: false,
          ),
          ComponentsSelectGizi(
            isShowText: false,
            text: "Gizi",
            onCategorySelected: (index) {
              setState(() {
                selectedGiziIndex = index;
              });
            },
          ),
          const SizedBox(height: defaultSize * 0.75),
          ComponentsListKids(
            searchText: _searchText,
            selectedGiziIndex: selectedGiziIndex,
          ),
        ],
      ),
    );
  }
}

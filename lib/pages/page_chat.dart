import 'package:flutter/material.dart';

import '../components/components_list_user.dart';
import '../components/components_button.dart';
import '../components/components_title_page.dart';
import '../configs/config_apps.dart';

class PageChat extends StatelessWidget {
  const PageChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
          ComponentsTitlePage(
            title: "Halaman Pesan",
          ),
          ComponentsListUser(),
        ],
      ),
    );
  }
}

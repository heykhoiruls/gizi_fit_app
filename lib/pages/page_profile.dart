import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components_data_user.dart';
import '../components/components_button.dart';
import '../components/components_title_page.dart';
import '../configs/config_apps.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
          const ComponentsTitlePage(
            title: "Halaman Profile",
          ),
          ComponentsDataUser(
            id: currentUserId,
          ),
        ],
      ),
    );
  }
}

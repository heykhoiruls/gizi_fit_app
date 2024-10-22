import 'package:flutter/material.dart';

import '../../pages/page_auth/page_choose_role.dart';
import '../../configs/config_apps.dart';
import '../page_first.dart';

class PageRoleValidation extends StatelessWidget {
  final String id;
  const PageRoleValidation({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: controllerUser.streamUsers.doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: colorPrimary,
              ),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var data = snapshot.data?.data();

          if (data?['role'] == null) {
            return const PageChooseRole();
          } else {
            return const PageFirst();
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/page_chat/page_chat_room.dart';
import '../components/components_empty.dart';
import '../configs/config_apps.dart';
import 'components_transition.dart';
import 'components_list.dart';

class ComponentsListUser extends StatelessWidget {
  const ComponentsListUser({
    super.key,
  });

  Widget buildKids(BuildContext context, QuerySnapshot snapdata) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: snapdata.size,
        itemBuilder: (context, index) {
          var data = snapdata.docs[index].data() as Map<String, dynamic>;
          if (data['uid'] == currentUserId) {
            return const SizedBox.shrink();
          }
          if (data['role'] == messageDefault) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              if (index == 1) const SizedBox(height: defaultSize),
              ComponentsList(
                onTap: () {
                  Navigator.push(
                    context,
                    transitionRight(
                      PageChatRoom(
                        idReceiver: data['uid'],
                        idSender: currentUserId,
                      ),
                    ),
                  );
                },
                photo: data['photo'],
                name: data['name'],
                text: data['role'],
              ),
              const SizedBox(height: defaultSize * 0.2),
              if (index == snapdata.size - 1)
                const SizedBox(height: defaultSize * 6)
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerUser.streamUsers
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasData) {
          var data = snapshot.data as QuerySnapshot;
          if (data.docs.isNotEmpty && data.docs.length > 1) {
            return buildKids(context, data);
          } else {
            return const Expanded(
              child: Column(
                children: [
                  SizedBox(height: defaultSize * 4),
                  ComponentsEmpty(
                    photo: imagePageHomeEmpty,
                    text: messageChatEmpty,
                  ),
                ],
              ),
            );
          }
        } else {
          return const ComponentsEmpty(
            photo: imagePageHomeEmpty,
            text: messageChatEmpty,
          );
        }
      },
    );
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../components/components_chat_content.dart';
import '../../components/components_header.dart';
import '../../components/components_empty.dart';
import '../../components/components_row.dart';
import '../../configs/config_apps.dart';
import '../../models/model_chat.dart';

class PageChatRoom extends StatefulWidget {
  final String idReceiver;
  final String idSender;
  const PageChatRoom({
    super.key,
    required this.idReceiver,
    required this.idSender,
  });
  static const route = "/page-chat-room";

  @override
  State<PageChatRoom> createState() => _PageChatRoomState();
}

class _PageChatRoomState extends State<PageChatRoom> {
  ModelChat chat = ModelChat();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    String messageText = user.controllerMessage.text;

    if (messageText.isNotEmpty) {
      await chat.sendMessage(
        widget.idReceiver,
        messageText,
        Timestamp.now(),
      );

      await chat.updateTimestamp(
        widget.idSender,
        widget.idReceiver,
        Timestamp.now(),
      );
    }

    user.controllerMessage.clear();

    DocumentSnapshot snapSender = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.idSender)
        .get();

    DocumentSnapshot snapReceiver = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.idReceiver)
        .get();

    String token = snapReceiver['token'];
    String name = snapSender['name'];
    String role = snapSender['role'];

    sendPushMessage(token, name, role, messageText);
  }

  void sendPushMessage(
    String token,
    String name,
    String role,
    String message,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAPxBs3_E:APA91bFAwl2GHlUJw6Ow6cPao5UBUwBUlK9ZaFvUSptwrttVLFWX5UzMjpa_rQ37Ob4KHsWt9MvlIxK-C-5FEpUS9M2aiX3uTTVCl2WtEJ4IKpvg2Wwk4JX2uBuP27cu9nc7d_sZJizD',
        },
        body: jsonEncode(
          {
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'title': "$name - $role",
              'body': message,
            },
            'notification': <String, dynamic>{
              'android_channel_id': 'mawar_care',
              'title': "$name - $role",
              'body': message,
            },
            'to': token,
          },
        ),
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  Widget buildMesssageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chat.getMessages(widget.idReceiver, currentUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        final messages = snapshot.data!.docs;
        if (messages.isEmpty) {
          return const ComponentsEmpty(
            photo: imagePageChatEmpty,
            text: messagePageChatEmpty,
          ); // Show empty state widget
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        });
        return Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return buildMessageItem(messages[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return ComponentsChatContent(
      message: data["message"],
      idReceiver: data["idReceiver"],
      idSender: data["idSender"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ComponentsHeader(
              text: "Ruang Obrolan",
            ),
            buildMesssageList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultSize),
              child: ComponentsRow(
                textHint: "Ketik pesan . . .",
                controller: user.controllerMessage,
                icon: const LineIcon.telegramPlane(
                  color: colorBlack,
                ),
                onTap: () {
                  sendMessage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

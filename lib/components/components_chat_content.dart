import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import 'components_chat_bubble.dart';

class ComponentsChatContent extends StatelessWidget {
  final String message;
  final String idReceiver;
  final String idSender;
  const ComponentsChatContent({
    super.key,
    required this.message,
    required this.idReceiver,
    required this.idSender,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultSize * 0.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: (idSender == currentUserId)
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ComponentsChatBubble(
                  borderRadiusGeometry: (idSender == currentUserId)
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                          bottomLeft: Radius.circular(defaultRadius),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                          bottomLeft: Radius.circular(defaultRadius),
                        ),
                  crossAlignment: (idSender == currentUserId)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  message: message,
                  colorContainer:
                      (idSender == currentUserId) ? colorPrimary : colorAccent,
                  colorDate: (idSender == currentUserId)
                      ? colorBackground
                      : colorBlack,
                  colorText: (idSender == currentUserId)
                      ? colorBackground
                      : colorBlack,
                  date: "12:12 PM",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

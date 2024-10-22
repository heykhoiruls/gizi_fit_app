// ignore_for_file: use_build_context_synchronously

import 'package:line_icons/line_icon.dart';
import 'package:flutter/material.dart';

import '../components/components_transition.dart';
import '../configs/config_components.dart';
import '../pages/page_first.dart';
import '../pages/page_kids/page_kids_edit.dart';
import '../configs/config_apps.dart';
import 'components_modal_bottom.dart';

class ComponentsMenu extends StatelessWidget {
  final String id;
  const ComponentsMenu({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 48,
        maxWidth: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: colorAccent,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  transitionRight(
                    PageKidsEdit(id: id),
                  ),
                );
              },
              child: const Center(
                child: LineIcon.edit(
                  color: colorBlack,
                ),
              ),
            ),
          ),
          const LineDeviderVertical(
            lineHeight: defaultSize,
            colorChoose: colorBlack,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => modalBottom(
                context,
                messageDeleteKids,
                id,
                () async {
                  Navigator.push(
                    context,
                    transitionLeft(const PageFirst()),
                  );
                  await controllerKid.streamKids.doc(id).delete();
                  await controllerImmun.streamsImmunization.doc(id).delete();
                },
              ),
              child: const Center(
                child: LineIcon.trash(
                  color: colorBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

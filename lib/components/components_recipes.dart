// ignore_for_file: prefer_const_constructors
// sized_box_for_whitespace
// avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gizi_fit_app/configs/config_apps.dart';
import 'package:google_fonts/google_fonts.dart';

class ComponentsRecipe extends StatelessWidget {
  final int itemCount;
  final Function(int)? onTap;
  final String Function(int) image;
  final String Function(int) label;

  const ComponentsRecipe({
    required this.itemCount,
    required this.onTap,
    required this.image,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: defaultSize,
          mainAxisSpacing: defaultSize * 2,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          padding: EdgeInsets.symmetric(horizontal: defaultSize),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTap!(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: index == 1 ? 280 : 240,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultSize),
                      child: Container(
                        child: Image.network(
                          image(index),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Text(
                            label(index),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SizedBox(height: 100),
      ],
    );
  }
}

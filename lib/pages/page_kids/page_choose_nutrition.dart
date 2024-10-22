// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gizi_fit_app/components/components_header.dart';
import 'package:gizi_fit_app/configs/config_apps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';

import '../../models/model_nutrition.dart';

class PageChooseNutrition extends StatefulWidget {
  final String id;

  PageChooseNutrition({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _PageChooseNutritionState createState() => _PageChooseNutritionState();
}

class _PageChooseNutritionState extends State<PageChooseNutrition> {
  TextEditingController searchController = TextEditingController();
  List<Nutrition> recipes = [];
  int selectedFoodIndex = 0;
  String searchQuery = "";
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();

    //
    searchQuery = list.food[selectedFoodIndex];

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        if (!isFirstLoad) {
          loadRecipes();
        }
      });
    });

    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      if (searchQuery.isNotEmpty) {
        List<Nutrition> result = await getRecipe(searchQuery);
        setState(() {
          recipes = result;
        });
      }
    } catch (e) {
      print('Error loading recipes: $e');
    }
  }

  Future<List<Nutrition>> getRecipe(String query) async {
    var response = await http.get(
      Uri.https(
        'api.edamam.com',
        '/search',
        {
          'q': query,
          'app_id': '00115865',
          'app_key': 'd1eaf99f7b68e66bee098d9bbae0ada0',
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<Nutrition> recipes = [];

      for (var hit in jsonData['hits']) {
        var recipe = hit['recipe'];
        var nutrients = recipe['totalNutrients'];
        recipes.add(
          Nutrition(
            photo: recipe['image'],
            text: recipe['label'],
            kalori: recipe['calories'],
            protein: nutrients['PROCNT']['quantity'],
            karbohidrat: nutrients['CHOCDF']['quantity'],
            lemak: nutrients['FAT']['quantity'],
            air: nutrients['WATER']['quantity'],
            serat: nutrients['FIBTG']['quantity'],
          ),
        );
      }

      return recipes;
    } else {
      throw Exception('Failed to get recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ComponentsHeader(text: "Choose meal"),
            Padding(
              padding: const EdgeInsets.only(
                left: defaultSize,
                right: defaultSize,
                bottom: defaultSize,
                top: defaultSize / 2,
              ),
              child: TextField(
                style: GoogleFonts.poppins(),
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(defaultSize),
                  prefixIcon: IconTheme(
                    data: IconThemeData(color: Colors.grey.shade300),
                    child: LineIcon.search(),
                  ),
                  hintText: "Search Menu",
                ),
                onSubmitted: (query) {
                  loadRecipes();
                },
              ),
            ),
            // ComponentsCategoryRecomendation(
            //   onCategorySelected: (selectedFood) {
            //     setState(() {
            //       searchQuery = selectedFood;
            //       loadRecipes();
            //     });
            //   },
            // ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  MasonryGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    padding: EdgeInsets.symmetric(horizontal: defaultSize),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RecipeDetailPage(
                          //       recipe: recipes[index],
                          //       id: widget.id,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: index == 1 ? 280 : 240,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(defaultSize),
                                child: Container(
                                  child: Image.network(
                                    recipes[index].photo,
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
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Text(
                                      recipes[index].text,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

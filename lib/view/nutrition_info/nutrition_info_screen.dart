import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/res/component/list_tile1.dart';
import 'package:CoachBot/res/component/reusable_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../res/component/input_text_field.dart';
import '../../view_model/nutrition_info/nutrition_info_provider.dart';

class NutritionDataScreen extends StatelessWidget {
  final TextEditingController _itemController = TextEditingController();
  late final isLoading;

  NutritionDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NutritionDataProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition Facts'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Consumer<NutritionDataProvider>(
            builder: (context, nutritionProvider, child) {
              bool hasSearchResult = nutritionProvider.nutritionFacts != null;
              bool hasError = nutritionProvider.loading;
              return Column(
                children: [
                  // TextField(
                  // autofocus: true,
                  // ),
                  CustomTextField(
                    myController: _itemController,
                    keyBoardType: TextInputType.text,
                    autoFocus: true,
                    labelText: 'Enter food item',
                    onValidator: (value) {
                      if (value == null) {}
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                      title: 'Search',
                      loading: nutritionProvider.loading,
                      onTap: () {
                        String query = _itemController.text;
                        if (query.isNotEmpty) {
                          Provider.of<NutritionDataProvider>(context,
                                  listen: false)
                              .fetchData(query);
                        }
                      }),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     isLoading = true;
                  //
                  //   },
                  //   child: const Text('Search'),
                  // ),

                  SizedBox(height: 50.h),
                  hasError
                      ? const Center(
                          child: Text('searching...'),
                        )
                      : hasSearchResult
                          ? Expanded(
                              child: ListView(
                                children: [
                                  Center(
                                    child: Text('Nutrition Facts',
                                        style: TextStyle(
                                          letterSpacing: 5,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green,
                                        )),
                                  ),
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: Text(
                                        '${nutritionProvider.nutritionFacts!.name.toUpperCase()}',
                                        style: const TextStyle(
                                          letterSpacing: 5,
                                          fontSize: 20,
                                          color: Colors.green,
                                        )),
                                  ),
                                  SizedBox(height: 20.h),
                                  ListTile1(
                                    title: Text('Serving Size',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.servingSize.toInt()} gram',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),

                                  ),
                                  SizedBox(height: 20.h),
                                  ListTile1(
                                    title: const Text('Calories'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.calories}'),

                                  ),
                                  ListTile1(
                                    title: const Text('Protien'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.protein} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Carbs'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.totalCarbohydrates} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Total Fat'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.totalFat} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Saturated Fat'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.saturatedFat} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Fiber'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.fiber} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Sugar'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.sugar} g'),
                                  ),
                                  ListTile1(
                                    title: const Text('Cholesterol'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.cholesterol} mg'),
                                  ),
                                  ListTile1(
                                    title: const Text('Sodium'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.sodium} mg'),
                                  ),
                                  ListTile1(
                                    title: const Text('Potassium'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.potassium} mg'),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Container(),
                            ),
                  // Center(
                  //         child: Container(),
                  //       ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

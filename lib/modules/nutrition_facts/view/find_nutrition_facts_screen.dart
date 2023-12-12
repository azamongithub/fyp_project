import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_text_field.dart';
import '../../../common_components/nutrition_list_tile.dart';
import '../../../theme/text_style_util.dart';
import '../controller/nutrition_facts_controller.dart';

class FindNutritionFactsScreen extends StatelessWidget {
  final TextEditingController _itemController = TextEditingController();
  late final isLoading;

  FindNutritionFactsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NutritionDataController(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('Nutrition Facts ', style: CustomTextStyle.appBarStyle()),
          backgroundColor: const Color(0xff3140b0),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Consumer<NutritionDataController>(
            builder: (context, nutritionProvider, child) {
              bool hasSearchResult = nutritionProvider.nutritionFacts != null;
              bool hasError = nutritionProvider.loading;
              return Column(
                children: [
                  CustomTextField(
                    myController: _itemController,
                    keyBoardType: TextInputType.text,
                    autoFocus: true,
                    labelText: 'Enter food item',
                    onChange: (value) {
                      String query = _itemController.text;
                      if (query.isNotEmpty) {
                        Provider.of<NutritionDataController>(context,
                                listen: false)
                            .fetchNutritionFactsData(query);
                      }
                    },
                    onValidator: (value) {
                      if (value == null) {}
                    },
                  ),
                  SizedBox(height: 70.h),
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
                                  NutririonListTile(
                                    title: Text(
                                      'Serving Size',
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.servingSize.toInt()} gram',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  SizedBox(height: 20.h),
                                  NutririonListTile(
                                    title: const Text('Calories'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.calories}'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Protien'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.protein} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Carbs'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.totalCarbohydrates} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Total Fat'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.totalFat} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Saturated Fat'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.saturatedFat} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Fiber'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.fiber} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Sugar'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.sugar} g'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Cholesterol'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.cholesterol} mg'),
                                  ),
                                  NutririonListTile(
                                    title: const Text('Sodium'),
                                    trailing: Text(
                                        '${nutritionProvider.nutritionFacts!.sodium} mg'),
                                  ),
                                  NutririonListTile(
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

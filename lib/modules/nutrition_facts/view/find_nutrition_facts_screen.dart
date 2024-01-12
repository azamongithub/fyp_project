// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:CoachBot/common_components/custom_button.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_text_field.dart';
import '../../../common_components/nutrition_list_tile.dart';
import '../../../theme/text_style_util.dart';
import '../controller/nutrition_facts_controller.dart';

class FindNutritionFactsScreen extends StatelessWidget {
  const FindNutritionFactsScreen({super.key});
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Consumer<NutritionDataController>(
            builder: (context, provider, child) {
              bool hasSearchResult = provider.nutritionFacts?.name != null;
              bool isLoading = provider.loading;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter a food item',
                    style: CustomTextStyle.textStyle22(),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    myController: provider.itemController,
                    keyBoardType: TextInputType.text,
                    labelText: 'Pizza',
                    autoFocus: true,
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomButton(
                      loading: provider.loading,
                        title: 'Search',
                        onTap: (){
                          String query = provider.itemController.text;
                          if (query.isNotEmpty) {
                            Provider.of<NutritionDataController>(context,
                                listen: false)
                                .fetchNutritionFactsData(query);
                          }
                          else {
                            Utils.negativeToastMessage('Please enter a food item first');
                          }
                        },
                        height: 50.h,
                        width: 150.w,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  isLoading
                      ? Container()
                      :
                  hasSearchResult
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
                                        provider.nutritionFacts!.name.toUpperCase(),
                                        style: const TextStyle(
                                          letterSpacing: 5,
                                          fontSize: 20,
                                          color: Colors.green,
                                        )),
                                  ),
                                  SizedBox(height: 20.h),
                                  NutritionListTile(
                                    title: Text(
                                      'Serving Size',
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.servingSize.toInt()} gram',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  SizedBox(height: 20.h),
                                  NutritionListTile(
                                    title: const Text('Calories'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.calories}'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Protien'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.protein} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Carbs'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.totalCarbohydrates} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Total Fat'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.totalFat} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Saturated Fat'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.saturatedFat} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Fiber'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.fiber} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Sugar'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.sugar} g'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Cholesterol'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.cholesterol} mg'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Sodium'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.sodium} mg'),
                                  ),
                                  NutritionListTile(
                                    title: const Text('Potassium'),
                                    trailing: Text(
                                        '${provider.nutritionFacts!.potassium} mg'),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Container(),
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

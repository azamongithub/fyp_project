import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/custom_text_field.dart';
import '../../../theme/text_style_util.dart';
import '../controller/send_feedback_controller.dart';

class SendFeedbackScreen extends StatelessWidget {
  const SendFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.feedback, style: CustomTextStyle.appBarStyle()),
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.themeColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ChangeNotifierProvider(
                  create: (_) => SendFeedbackController(),
                  child: Consumer<SendFeedbackController>(
                      builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            AppStrings.sendFeedbackLabel,
                            style: CustomTextStyle.textStyle22(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          myController: provider.feedbackController,
                          keyBoardType: TextInputType.text,
                          maxLines: 7,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.requiredField;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50.h),
                        CustomButton(
                          title: AppStrings.sendButton,
                          loading: provider.isLoading,
                          height: 50.h,
                          width: 400.w,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              provider.saveFeedback(context);
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

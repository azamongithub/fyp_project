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
    final TextEditingController feedbackController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.feedback,
            style: CustomTextStyle.appBarStyle()),
        iconTheme: IconThemeData(color: ColorUtil.whiteColor),
        backgroundColor: const Color(0xff3140b0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    AppStrings.sendFeedbackLabel,
                    style: CustomTextStyle.textStyle22(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  myController: feedbackController,
                  keyBoardType: TextInputType.text,
                  //labelText: AppStrings.sendFeedbackLabel,
                  maxLines: 7,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.enterFeedback;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 70.h),
                ChangeNotifierProvider(
                  create: (_) => SendFeedbackController(),
                  child: Consumer<SendFeedbackController>(
                      builder: (context, provider, child) {
                    return CustomButton(
                      title: AppStrings.sendButton,
                      loading: provider.isLoading,
                      height: 50.h,
                      width: 400.w,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          provider.saveFeedback(context);
                        }
                      },
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

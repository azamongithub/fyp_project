import 'package:CoachBot/common_components/custom_button.dart';
import 'package:CoachBot/common_components/custom_text_field.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_string_constants.dart';

class SendMsgToEmailScreen extends StatefulWidget {
  const SendMsgToEmailScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<SendMsgToEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Doctor',
          style: CustomTextStyle.appBarStyle(),
        ),
        backgroundColor: AppColors.themeColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.sendMessageLabel,
                    style: CustomTextStyle.textStyle22(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Text(
                //   'Your Name',
                //   style: CustomTextStyle.textStyle20(
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                CustomTextField(
                  myController: _nameController,
                  labelText: 'Your Name',
                  keyBoardType: TextInputType.text,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'Message',
                  style: CustomTextStyle.textStyle20(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  myController: _messageController,
                  keyBoardType: TextInputType.text,
                  maxLines: 7,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Center(
                  child: CustomButton(
                      title: 'Send Email',
                      height: 50.h,
                      width: 200.w,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _sendEmail();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendEmail() async {
    String name = _nameController.text;
    String message = _messageController.text;
    String subject = 'Form Submission from $name';

    final Email email = Email(
      body: message,
      subject: subject,
      to: ['ansarimuhammadazam1@email.com'],
    );
    EmailLauncher.launch(email).then((value) {
      // success
      Utils.positiveToastMessage('Your Message has been sent');
      if (kDebugMode) {
        print(value);
      }
    }).catchError((error) {
      // has error
      if (kDebugMode) {
        print(error);
      }
    });
  }
}

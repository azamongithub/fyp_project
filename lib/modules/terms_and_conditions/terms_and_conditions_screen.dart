import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color_util.dart';
import '../../theme/text_style_util.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Terms and Conditions',
          style: CustomTextStyle.appBarStyle(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadingText(text: 'CoachBot App Terms and Conditions'),
            SubHeadingText(text: 'Last Updated: January 10, 2024'),
            DescriptionText(
                text:
                    'Welcome to CoachBot, an AI-based fitness app designed to provide personalized workout and meal plans. Before using the CoachBot app, please read the following terms and conditions carefully.'),
            HeadingText(text: '1. Acceptance of Terms'),
            DescriptionText(
                text:
                    'By using CoachBot, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use the app.'),
            SubHeadingText(text: '2. User Registration'),
            DescriptionText(
                text:
                    'To access certain features of CoachBot, you must register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.'),
            SubHeadingText(text: '3. Personal Information'),
            DescriptionText(
                text:
                    'CoachBot collects and processes personal information as described in our Privacy Policy. By using the app, you consent to the collection and use of your personal information in accordance with our Privacy Policy.'),
            SubHeadingText(text: '4. User Responsibilities'),
            DescriptionText(
                text:
                    '● You are responsible for maintaining the confidentiality of your account credentials.\n'
                    '● You agree not to share your account information with others.\n'
                    '● You are solely responsible for any activity that occurs under your account.'),
            SubHeadingText(text: '5. Health Information'),
            DescriptionText(
                text:
                    'Before starting any workout or meal plan provided by CoachBot, it is recommended that you consult with a qualified healthcare professional. CoachBot is not a substitute for professional medical advice, diagnosis, or treatment.'),
            SubHeadingText(text: '6. Customized Plans'),
            DescriptionText(
                text:
                    'The workout and meal plans provided by CoachBot are generated based on the information you provide, including your health status. It is essential to update your information regularly to ensure the plans remain accurate.'),
            SubHeadingText(text: '7. Limitation of Liability'),
            DescriptionText(
                text:
                    'CoachBot and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses.'),
            SubHeadingText(text: '8. Termination'),
            DescriptionText(
                text:
                    'CoachBot reserves the right to terminate or suspend your account without notice if you violate these terms or engage in any illegal or fraudulent activities.'),
            SubHeadingText(text: '9. Changes to Terms'),
            DescriptionText(
                text:
                    'CoachBot may update these terms at any time without prior notice. Your continued use of the app after such changes will constitute your acceptance of the revised terms.'),
            HeadingText(text: "9. Contact Us"),
            DescriptionText(text: 'If you have any questions or concerns about this Privacy Policy, please contact us at coachbotadmin@gmail.com.'),
            DescriptionText(text: "Thank you for using CoachBot!"),
          ],
        ),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomTextStyle.textStyle18(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String text;

  const SubHeadingText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomTextStyle.textStyle16(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomTextStyle.textStyle14(),
    );
  }
}

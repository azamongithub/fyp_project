import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/color_util.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text('Privacy Policy',
          style: CustomTextStyle.appBarStyle(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadingText(text: 'CoachBot App Privacy Policy'),
            SubHeadingText(text: 'Last Updated: January 10, 2024'),
            DescriptionText(
                text:
                    'Welcome to CoachBot, an AI-based fitness app. This Privacy Policy outlines how CoachBot collects, uses, and protects your personal information. By using the CoachBot app, you agree to the practices described in this policy.'),
            HeadingText(text: '1. Information We Collect'),
            DescriptionText(
                text: 'CoachBot collects the following types of information:'),
            SubHeadingText(text: '◗ Personal Information'),
            DescriptionText(
                text:
                    'This may include your name, date of birth, gender, weight, height, fitness goals, and any health conditions you choose to disclose.'),
            SubHeadingText(text: '◗ Usage Data'),
            DescriptionText(
                text:
                    'We collect information about your interactions with the app, including the pages you view and the features you use.'),
            SubHeadingText(text: '◗ Device Information'),
            DescriptionText(
                text:
                    'We collect information about the device you use to access the app, such as device type, operating system, and unique device identifiers.'),
            HeadingText(text: '2. How We Use Your Information'),
            DescriptionText(
                text:
                    'CoachBot uses the collected information for the following purposes:'),
            SubHeadingText(text: '◗ Personalized Plans'),
            DescriptionText(
                text:
                    'To generate customized workout and meal plans based on the information you provide.'),
            SubHeadingText(text: '◗ App Improvement'),
            DescriptionText(
                text:
                    'To analyze usage patterns and improve the functionality and user experience of the app'),
            SubHeadingText(text: '◗ Communication'),
            DescriptionText(
                text:
                    'To send you important updates, notifications, and information related to the app.'),
            HeadingText(text: '3. Information Sharing'),
            DescriptionText(
                text:
                    'We do not sell, trade, or otherwise transfer your personal information to third parties. However, we may share aggregated and anonymized data for research or marketing purposes.'),
            HeadingText(text: '4. Security'),
            DescriptionText(
                text:
                    'CoachBot employs reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction.'),
            HeadingText(text: '5. Third-Party Links'),
            DescriptionText(
                text:
                    'The CoachBot app may contain links to third-party websites or services. We are not responsible for the privacy practices of these third parties.'),
            HeadingText(text: "7. Children's Privacy"),
            DescriptionText(
                text:
                    'CoachBot is not intended for individuals under the age of 13. We do not knowingly collect personal information from children under 13.'),
            HeadingText(text: "8. Changes to Privacy Policy"),
            DescriptionText(text: "CoachBot reserves the right to update this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated policy."),
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

import 'package:CoachBot/common_components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/password_text_field.dart';
import '../../../constants/app_string_constants.dart';
import '../../../theme/text_style_util.dart';
import '../controller/delete_account_controller.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});
  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Account',
          style: CustomTextStyle.appBarStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Text(
              'Please Enter your Password to delete your account',
              style: CustomTextStyle.textStyle22(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15.h),
            ChangeNotifierProvider(
              create: (context) => DeleteAccountController(),
              child: Consumer<DeleteAccountController>(
                  builder: (context, provider, child) {
                return Column(children: [
                  Form(
                    key: _formKey,
                    child: PasswordTextField(
                      controller: provider.passwordController,
                      labelText: AppStrings.password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.emptyPassword;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    loading: provider.isLoading,
                    title: 'Delete Account',
                    height: 50.h,
                    width: 1.sw * 0.7,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final provider = Provider.of<DeleteAccountController>(
                            context,
                            listen: false);
                        provider.deleteAccount(context);
                      }
                    },
                  ),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/modules/change_password/controller/change_password_controller.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/password_text_field.dart';
import '../../../theme/text_style_util.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(AppStrings.changePassBtn,
            style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.h),
                PasswordTextField(
                  controller: _currentPasswordController,
                  labelText: AppStrings.currentPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.enterCurrentPass;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.h),
                PasswordTextField(
                  controller: _newPasswordController,
                  labelText: AppStrings.newPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.enterNewPass;
                    } else if (_currentPasswordController.text ==
                        _newPasswordController.text) {
                      return AppStrings.newPassNotEqualCurrentPass;
                    } else if (value!.length < 6) {
                      return AppStrings.passValidation;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.h),
                PasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: AppStrings.confirmPassLabel,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return AppStrings.confirmNewPass;
                    }
                    if (value != _newPasswordController.text) {
                      return AppStrings.passNotMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.h),
                ChangeNotifierProvider(
                  create: (_) => ChangePasswordController(),
                  child: Consumer<ChangePasswordController>(
                    builder: (context, provider, child) {
                      return CustomButton(
                        title: AppStrings.changePassBtn,
                        loading: provider.loading,
                        height: 50.h,
                        width: 400.w,
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            provider.changePassword(context, _currentPasswordController.text, _newPasswordController.text);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_style_util.dart';
import '../../../common_components/custom_button.dart';
import '../../../common_components/custom_text_field.dart';
import '../../../routes/route_name.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorUtil.whiteColor),
          title: Text('Coachbot ', style: CustomTextStyle.appBarStyle()),
          backgroundColor: ColorUtil.themeColor,

        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Image(
                  //   height: 150,
                  //   width: 150,
                  //   image: AssetImage('images/fitness_logo1.jpg'),
                  // ),
                  SizedBox(height: height * 0.06.h),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff203142)),
                    ),
                  ),
                  SizedBox(height: height * 0.03.h),
                  const Center(
                      child: Text(
                    'Enter your email for the verification process. we will send you the reset passsword link to your email',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff203142)),
                  )),
                  SizedBox(height: height * 0.04),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            myController: emailController,
                            keyBoardType: TextInputType.emailAddress,
                            labelText: 'Email',
                            onValidator: (value) {
                              return value.isEmpty
                                  ? 'Please enter your email'
                                  : null;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04.h),

                  ChangeNotifierProvider(
                      create: (_) => ForgotPasswordController(),
                      child: Consumer<ForgotPasswordController>(
                          builder: (context, provider, child) {
                        return CustomButton(
                          title: 'Request Reset Link',
                          loading: provider.loading,
                          height: 50.h,
                          width: 400.w,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.forgotPassword(
                                  context, emailController.text);
                            }
                          },
                        );
                      })),

                  SizedBox(height: height * 0.02.h),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.loginForm);
                      },
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff3140b0)),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

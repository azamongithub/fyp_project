import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/view_model/signup/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/assets_constants.dart';
import '../../res/component/input_text_field.dart';
import '../../res/component/password_text_field.dart';
import '../../res/component/custom_button.dart';
import '../../theme/text_style_util.dart';
import '../../utils/routes/route_name.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');



  final _formKey = GlobalKey<FormState>();
  //bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorUtil.themeColor,
        automaticallyImplyLeading: false,
        title: const Center(child: Text(AppStrings.appName)),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(4),
        child: ChangeNotifierProvider(
          create: (_) => SignUpController(),
          child: Consumer<SignUpController>(
            builder: (context , provider, child){
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          height: 150.h,
                          width: 150.w,
                          image: const AssetImage(ImageConstants.appLogo),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                            child: Text(
                              AppStrings.signup,
                              style: MyTextStyle.headingStyle32(),
                            )),
                        SizedBox(height: 15.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.03),
                              CustomTextField(
                                  myController: emailController,
                                  keyBoardType: TextInputType.emailAddress,
                                  labelText: AppStrings.email,
                                  onValidator: (value) {
                                    if(value!.isEmpty){
                                      return AppStrings.emptyEmail;
                                    }
                                    else if(!emailRegExp.hasMatch(value)){
                                      return 'Invalid email format';
                                    }
                                    return null;


                                   // return value.isEmpty ? AppStrings.emptyEmail : null;
                                  }

                                  ),
                              SizedBox(height: 30.h),
                              PasswordTextField(
                                controller: passwordController,
                                labelText: AppStrings.password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.emptyPassword;
                                  }
                                  // else if(!passwordRegExp.hasMatch(value)){
                                  //   return 'The password must be 8 characters and at least one number';
                                  // }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 55.h),
                        CustomButton(
                          title: AppStrings.signupButton,
                          loading: provider.loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.signUp(context, emailController.text, passwordController.text);
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(AppStrings.alreadyMember),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: ColorUtil.themeColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteName.loginForm,
                                      (route) => false,
                                );
                              },
                              child: const Text(AppStrings.loginNow,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                ),
              );
              //);
            } ,
          ),

        )
          )
      ),
    );
  }
}

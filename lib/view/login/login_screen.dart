import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/constants/assets_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/component/input_text_field.dart';
import '../../res/component/password_text_field.dart';
import '../../res/component/custom_button.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/login/login_controller.dart';
import '../signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtil.themeColor,
          automaticallyImplyLeading: false,
          title: const Center(child: Text(AppStrings.title)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    AppStrings.login,
                    style: MyTextStyle.headingStyle32(),
                  )),
                  SizedBox(height: 30.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            myController: emailController,
                            keyBoardType: TextInputType.emailAddress,
                            labelText: AppStrings.email,
                            onValidator: (value) {
                              return value.isEmpty
                                  ? AppStrings.emptyEmail
                                  : null;
                            }),
                        SizedBox(height: 30.h),
                        PasswordTextField(
                          controller: passwordController,
                          labelText: AppStrings.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.emptyPassword;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.ForgotPasswordScreen);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: const Color(0xff3140b0),
                                  ),
                        ),
                      )),

                  SizedBox(height: 40.h),
                  ChangeNotifierProvider(
                      create: (_) => LoginController(),
                      child: Consumer<LoginController>(
                          builder: (context, provider, child) {
                        return CustomButton(
                            title: AppStrings.loginButton,
                            loading: provider.loading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                provider.login(context, emailController.text,
                                    passwordController.text);
                              }
                            });
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(AppStrings.notMember),
                      TextButton(
                        // style: TextButton.styleFrom(
                        //   primary: const Color(0xff3140b0),
                        // ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.SignupForm,
                                (route) => false,
                          );
                        },
                        child: const Text(
                          AppStrings.registerNow,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
// const SizedBox(height: 30,),
// Center(
//   child: InkWell(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginWithPhoneScreen()));
//       },
//       child: const Text('Login with Phone Number')),
// )
                ],
              ),
            ),
          ),
        ));
  }
}

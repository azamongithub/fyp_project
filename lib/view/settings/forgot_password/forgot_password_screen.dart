import 'package:CoachBot/res/component/input_text_field.dart';
import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/view_model/forgot_password/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          backgroundColor: const Color(0xff3140b0),
          title: const Center(child: Text('CoachBot')),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Image(
                  //   height: 150,
                  //   width: 150,
                  //   image: AssetImage('images/fitness_logo1.jpg'),
                  // ),
                  SizedBox(height: height * 0.06),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Rubik-Medium',
                          color: Color(0xff203142)),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  const Center(
                      child: Text(
                    'Enter your email for the verification process. we will send you the reset passsword link to your email',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Rubik-Medium',
                        color: Color(0xff203142)),
                  )),
                  SizedBox(height: height * 0.04),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputTextField(
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
                  SizedBox(height: height * 0.04),

                  ChangeNotifierProvider(
                      create: (_) => ForgotPasswordController(),
                      child: Consumer<ForgotPasswordController>(
                          builder: (context, provider, child) {
                        return CustomButton(
                          title: 'Request Reset Link',
                          loading: provider.loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.forgotPassword(
                                  context, emailController.text);
                            }
                          },
                        );
                      })),

                  SizedBox(height: height * 0.02),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.LoginForm);
                      },
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Rubik-Medium',
                            color: Color(0xff3140b0)),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

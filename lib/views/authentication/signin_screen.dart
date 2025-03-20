// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/providers/authentication/login_provider.dart';
import 'package:picknow/views/authentication/forgotpassword_screen.dart';
import 'package:picknow/views/authentication/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../core/costants/navigation/navigation.dart';
import '../../core/costants/theme/appcolors.dart';
import '../widgets/custombutton.dart';
import '../widgets/customsizedbox.dart';
import '../widgets/customtext.dart';
import '../widgets/customtextfield.dart';
import '../bottombar/bottombar.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Welcome Back!',
                        size: 0.048,
                        color: AppColors.grey,
                        weight: FontWeight.w500,
                      ),
                      CustomText(
                        text: 'Sign in to continue',
                        size: 0.05,
                        color: AppColors.blackColor,
                        weight: FontWeight.w800,
                      ),
                      CustomSizedBoxHeight(0.04),
                      CustomTextfield(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Enter your email id',
                        prefixIcon:
                            Icon(Icons.email_rounded, color: AppColors.grey),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBoxHeight(0.04),
                      SizedBox(
                        height: mediaqueryheight(0.075, context),
                        child: CustomTextfield(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: _isObscured,
                          label: 'Enter your password',
                          suffix: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.blackColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                          prefixIcon: Icon(Icons.lock, color: AppColors.grey),
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Password must be at least 5 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      CustomSizedBoxHeight(0.03),
                      GestureDetector(
                          onTap: () {
                            PageNavigations().push(ForgotpasswordScreen());
                          },
                          child: CustomText(
                            text: 'Forgot Password ?',
                            size: 0.035,
                            color: AppColors.blackColor,
                            weight: FontWeight.bold,
                          )),
                      CustomSizedBoxHeight(0.03),
                      authProvider.isLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool success = await authProvider.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );

                                  if (success) {
                                    PageNavigations().push(BottomBar());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Invalid credentials, try again!')),
                                    );
                                  }
                                }
                              },
                              text: 'Continue with Email',
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                             SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: "Don't have an account ?",
                              size: 0.04,
                              color: AppColors.blackColor),
                              TextButton(
                        onPressed: () {
                          PageNavigations().push(SignupScreen());
                        },
                        child: CustomText(text: 'Sign Up', size: 0.04, color: AppColors.orange,weight: FontWeight.bold,),
                       
                      ),
                        ],
                      ),
                      CustomSizedBoxHeight(0.4)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

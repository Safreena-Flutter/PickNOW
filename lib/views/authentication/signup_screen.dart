// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/views/authentication/otpscreen.dart';
import 'package:picknow/views/authentication/signin_screen.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:provider/provider.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/authentication/register_provider.dart';
import '../widgets/CustomTextfield.dart';
import '../widgets/custombutton.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }  else if (value.length != 10 || int.tryParse(value) == null) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }  else if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        "Let's get started",
                        style: TextStyle(fontSize: 18, color: AppColors.grey),
                      ),
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      CustomTextfield(
                        controller: nameController,
                        label: 'Enter your name',
                        prefixIcon: Icon(Icons.person, color: AppColors.grey),
                        validator: _validateName,
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        controller: phoneController,
                        label: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.phone, color: AppColors.grey),
                        validator: _validatePhone,
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        controller: emailController,
                        label: 'Enter your email id',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email, color: AppColors.grey),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        controller: passwordController,
                        label: 'Enter your password',
                        obscureText: _isObscured,
                        
                        prefixIcon: Icon(Icons.lock, color: AppColors.grey),
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
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 20),
                      authProvider.isLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await authProvider.registerUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    contact: phoneController.text,
                                  );

                                  if (authProvider.activationToken != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtpScreen(
                                          emailid:emailController.text ,
                                          activationToken:
                                              authProvider.activationToken!,
                                        ),
                                      ),

                                    );
                                     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('OTP sent successfully to your email')),
                      );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Registration failed')),
                                    );
                                  }
                                }
                              },
                              text: 'Register',
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Already have an account ?',
                              size: 0.04,
                              color: AppColors.blackColor),
                              TextButton(
                        onPressed: () {
                          PageNavigations().push(SigninScreen());
                        },
                        child: CustomText(text: 'Sign In', size: 0.04, color: AppColors.orange,weight: FontWeight.bold,),
                       
                      ),
                        ],
                      ),
                      CustomSizedBoxHeight(0.1),
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

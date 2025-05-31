// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/costants/navigation/navigation.dart';
import 'package:picknow/views/authentication/otpscreen.dart';
import 'package:picknow/views/authentication/signin_screen.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:provider/provider.dart';
import '../../costants/theme/appcolors.dart';
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

  bool _isPasswordObscured = true;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 10 || int.tryParse(value) == null) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.orange.withOpacity(0.8), // Deep Orange
              AppColors.orange, // Light Orange
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      // Logo or Brand Name
                      Image.asset(
                        'assets/images/logo.png', // Replace with your e-commerce logo
                        height: 180,
                        width: 180,
                      ),

                      Text(
                        'Welcome to PickNow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomSizedBoxHeight(0.015),
                      Text(
                        'SignUp in to continue shopping',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                // Sign In Form
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildTextField(
                          controller: nameController,
                          hintText: 'Name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          validator: _validateName,
                        ),
                        SizedBox(height: 20),
                        buildTextField(
                          controller: phoneController,
                          hintText: 'Phone Number',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.number,
                          validator: _validatePhone,
                        ),
                        SizedBox(height: 20),
                        buildTextField(
                            controller: emailController,
                            hintText: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail),
                        SizedBox(height: 20),

                        // Password TextField
                        buildTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isPasswordObscured,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Password must be at least 5 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        authProvider.isLoading
                            ? Center(child: CircularProgressIndicator(color: AppColors.grey,))
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
                                            emailid: emailController.text,
                                            activationToken:
                                                authProvider.activationToken!,
                                          ),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'OTP sent successfully to your email')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Registration failed')),
                                      );
                                    }
                                  }
                                },
                                text: 'Sign Up',
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),

                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            GestureDetector(
                              onTap: () {
                                PageNavigations().push(SigninScreen());
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(0xFFFF6F00),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
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

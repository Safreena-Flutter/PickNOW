// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/costants/mediaquery/mediaquery.dart';
import '../../core/costants/navigation/navigation.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/authentication/login_provider.dart';
import '../widgets/custombutton.dart';
import '../widgets/customsizedbox.dart';
import '../widgets/customtext.dart';
import '../widgets/customtextfield.dart';
import 'resetpassword_screen.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSizedBoxHeight(0.05),
              CustomText(
                text: 'Forgot Password',
                size: 0.06,
                color: AppColors.orange,
                weight: FontWeight.w700,
              ),
              CustomSizedBoxHeight(0.04),
              SizedBox(
                width: mediaquerywidth(0.8, context),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: "Enter the email associated with your account.",
                  size: 0.04,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
              ),
              CustomSizedBoxHeight(0.08),
              CustomTextfield(
                controller: emailController,
                label: 'Enter your email id',
                prefixIcon: const Icon(Icons.email_rounded),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!value.contains('@') || !value.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              CustomSizedBoxHeight(0.1),
              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool isSent = await authProvider.forgotPassword(
                            emailController.text.trim(),
                          );

                          if (isSent) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Password reset code sent to your email'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            PageNavigations().push(
                              ResetpasswordScreen(email: emailController.text),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Failed to send reset code. Try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      text: 'Send Reset Code',
                      textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

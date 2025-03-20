// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/providers/authentication/login_provider.dart';
import 'package:provider/provider.dart';
import '../../core/costants/navigation/navigation.dart';
import '../../core/costants/theme/appcolors.dart';
import '../authentication/signin_screen.dart';
import '../widgets/custombutton.dart';
import '../widgets/customsizedbox.dart';
import '../widgets/customtext.dart';
import '../widgets/customtextfield.dart';

class ResetpasswordScreen extends StatefulWidget {
  final String email;
  const ResetpasswordScreen({super.key, required this.email});

  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSizedBoxHeight(0.05),
                CustomText(
                  text: 'Reset Password',
                  size: 0.06,
                  color: AppColors.orange,
                  weight: FontWeight.w700,
                ),
                CustomSizedBoxHeight(0.08),
                CustomTextfield(
                  controller: resetCodeController,
                  label: 'Enter your reset code',
                  prefixIcon: const Icon(Icons.numbers),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Reset code is required';
                    }
                    return null;
                  },
                ),
                CustomSizedBoxHeight(0.04),
                CustomTextfield(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: _isObscured,
                  label: 'Enter your new password',
                  suffix: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.blackColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
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
                            bool isSuccess = await authProvider.resetPassword(
                              email: widget.email,
                              resetToken: resetCodeController.text.trim(),
                              newPassword: passwordController.text.trim(),
                            );
        
                            if (isSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password reset successful'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              PageNavigations().push(SigninScreen());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Reset failed. Please check your reset code.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        text: 'Reset Password',
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:picknow/views/bottombar/bottombar.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../providers/authentication/register_provider.dart';
import '../widgets/custombutton.dart';
import '../widgets/customsizedbox.dart';
import '../widgets/customtext.dart';

class OtpScreen extends StatefulWidget {
  final String activationToken;
  final String emailid;
  const OtpScreen(
      {super.key, required this.activationToken, required this.emailid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(6, (index) => FocusNode());

  String getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Enter OTP')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomSizedBoxHeight(0.05),
              CustomText(
                text: 'Verify your Email',
                size: 0.06,
                color: AppColors.orange,
                weight: FontWeight.w700,
              ),
              CustomSizedBoxHeight(0.06),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: "Enter the code we sent to your email",
                  size: 0.04,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
              ),
              CustomSizedBoxHeight(0.08),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: otpControllers[index],
                        focusNode: otpFocusNodes[index],
                        autofocus: index == 0,
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context)
                                .requestFocus(otpFocusNodes[index + 1]);
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.orange),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CustomSizedBoxHeight(0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Didn't get the code?",
                    size: 0.035,
                    color: AppColors.grey,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(width: 5),
                  otpProvider.isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            await otpProvider.resentotp(
                                email: "user@example.com");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'OTP sent successfully to your email')),
                            );
                          },
                          child: CustomText(
                            text: "Resend it.",
                            size: 0.04,
                            color: AppColors.blackColor,
                            weight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
              CustomSizedBoxHeight(0.06),
              otpProvider.isVerifying
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      onPressed: () async {
                        String otp = getOtp();

                        if (otp.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Enter a valid 6-digit OTP')),
                          );
                          return;
                        }

                        bool isSuccess = await otpProvider.verifyOtp(
                          widget.activationToken,
                          otp,
                        );

                        if (isSuccess) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Invalid OTP, please try again')),
                          );
                        }
                      },
                      text: 'Verify & Continue',
                      textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:picknow/costants/mediaquery/mediaquery.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/authentication/signin_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/customtext.dart';
import 'intro_screen1.dart';
import 'intro_screen2.dart';
import 'intro_screen3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [IntroScreen1(), IntroScreen2(), IntroScreen3()],
          ),
          Container(
              alignment: Alignment(0, 0.78),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()),
                          );
                    },
                    child: CustomText(
                      text: 'Skip',
                      size: 0.04,
                      color: AppColors.blackColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                  SmoothPageIndicator(
                    effect: SwapEffect(
                        dotWidth: 15,
                        dotHeight: 5,
                        activeDotColor: AppColors.orange,
                        dotColor: AppColors.cream),
                    controller: controller,
                    count: 3,
                  ),
                  IconButton(
                      onPressed: () {
                        if (controller.page == 2) {
                          // Navigate to the sign-up screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()),
                          );
                        } else {
                          // Move to the next page
                          controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.orange),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: AppColors.orange,
                            size: mediaquerySize(0.12, context),
                          ),
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:picknow/providers/profile/userprofile_provider.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:provider/provider.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/widgets/custombutton.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:picknow/views/widgets/customtextfield.dart';

import '../../core/utils/sharedpreference_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
String profileImage = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()async {
      final userProvider = Provider.of<ProfileProvider>(context, listen: false);
      userProvider.loadUserProfile().then((_) {
        if (userProvider.user != null) {
          nameController.text = userProvider.user!.name;
          phoneController.text = userProvider.user!.contact;
          emailController.text = userProvider.user!.email;
        }
      });
        String savedImage = await SharedPrefsHelper.getProfileImage();
     if (savedImage.isNotEmpty) {
      setState(() {
        profileImage = savedImage;
      });
    }
    });
   
  }
void _changeProfileImage() async {
    // Show dialog to choose between two images
    String? selectedImage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: CustomText(text: 'Choose Profile Image', size: 0.04, color: AppColors.blackColor,weight: FontWeight.bold,)),
           
          content: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
     
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context,
                      "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg");
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context,
                      "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg");
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selectedImage != null) {
      setState(() {
        profileImage = selectedImage;
      });
      await SharedPrefsHelper.saveProfileImage(selectedImage);
    }
  }
     
    
    
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            PageNavigations().pop();
          },
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.lightgrey),
            child: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          ),
        ),
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Stack(
                    children: [
                      Container(
                     decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.grey)
                     ),
                        child: CircleAvatar(
                          radius: 50,

                          backgroundColor: AppColors.lightgrey,
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(4),  
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightgrey,
                            ),
                            child: const Icon(Icons.edit_outlined, color: AppColors.orange)),
                          onPressed: _changeProfileImage,
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBoxHeight(0.06),

                  CustomTextfield(controller: nameController, label: "Full Name"),
                  CustomSizedBoxHeight(0.02),

                  CustomTextfield(controller: phoneController, label: "Phone Number"),
                  CustomSizedBoxHeight(0.02),

                  CustomTextfield(controller: emailController, label: "Email ID"),
                  CustomSizedBoxHeight(0.06),

                  CustomElevatedButton(
                    onPressed: () async {
                            bool success = await userProvider.updateUserProfile(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                            );

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Profile updated successfully!")),
                              );
                              PageNavigations().pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(userProvider.error ?? "Failed to update profile")),
                              );
                            }
                          },
                    text: userProvider.isUpdating ? "Updating..." : "Save",
                    textColor: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
    );
  }
}

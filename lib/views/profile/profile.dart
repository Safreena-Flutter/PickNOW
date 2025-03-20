// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/providers/profile/userprofile_provider.dart';
import 'package:picknow/views/authentication/signin_screen.dart';
import 'package:picknow/views/profile/edit_profile.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/costants/navigation/navigation.dart';
import '../../core/utils/sharedpreference_helper.dart';
import '../../providers/cart/cart_provider.dart';
import '../cart/address.dart';
import '../cart/my_cart.dart';
import '../category/widget/category_iconwidget.dart';
import '../wishlist/wishlist.dart';
import 'my_orders.dart';

class ProfileScreen extends StatefulWidget {
  final String address;
  const ProfileScreen({super.key, required this.address});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileImage =
      "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg";

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).loadUserProfile();
    _loadProfileImage();
    super.initState();
  }

  Future<void> _loadProfileImage() async {
    String savedImage = await SharedPrefsHelper.getProfileImage();
    setState(() {
      profileImage = savedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        automaticallyImplyLeading: false,
        title: CustomText(
            text: "My Account", size: 0.04, color: AppColors.blackColor),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    PageNavigations().push(WishlistScreen());
                  },
                  icon: Icon(Icons.favorite_border)),
              Consumer<CartProvider>(
                builder: (_, cart, __) => buildAnimatedIconButton(
                  Icons.shopping_cart_outlined,
                  badge: cart.itemCount.toString(),
                  onPressed: () {
                    PageNavigations().push(ShoppingCart(isfromhome: true));
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSizedBoxHeight(0.04),
            userProvider.isLoading
                ? Center(child: const CircularProgressIndicator())
                : userProvider.error != null
                    ? Text("Error: ${userProvider.error}")
                    : userProvider.user != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: AppColors.grey)),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.lightgrey,
                                    backgroundImage: NetworkImage(profileImage),
                                  ),
                                ),
                                CustomSizedBoxWidth(0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: userProvider.user!.name,
                                      size: 0.04,
                                      color: AppColors.blackColor,
                                      weight: FontWeight.bold,
                                    ),
                                    CustomSizedBoxHeight(0.01),
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      text: userProvider.user!.contact,
                                      size: 0.035,
                                      color: AppColors.grey,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const Text("No user data available"),
            CustomSizedBoxHeight(0.02),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.person,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Edit Profile'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                PageNavigations().push(EditProfileScreen());
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.orange,
                ),
              ),
              title: Text('My Order'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                PageNavigations().push(MyOrdersScreen());
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.wallet,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Payments'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.location_history,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Address'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                PageNavigations().push(AddressScreen(widget.address, true));
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.lock,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Change Password'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                PageNavigations().push(AddressScreen(widget.address, true));
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.settings,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Settings'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.red,
                ),
              ),
              title: Text('Logout'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('auth_token'); // Remove stored token

                // Navigate to Onboarding/Login screen and clear previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                  (route) => false,
                );
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

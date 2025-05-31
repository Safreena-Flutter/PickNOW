// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/providers/profile/userprofile_provider.dart';
import 'package:picknow/providers/whishlist/whishlist_provider.dart';
import 'package:picknow/views/authentication/signin_screen.dart';
import 'package:picknow/views/profile/aboutus_screen.dart';
import 'package:picknow/views/profile/edit_profile.dart';
import 'package:picknow/views/widgets/customsizedbox.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../costants/navigation/navigation.dart';
import '../../utils/sharedpreference_helper.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).loadUserProfile();
      _loadProfileImage();
    });
    super.initState();
  }

  Future<void> _loadProfileImage() async {
    String? savedImage = await SharedPrefsHelper.getProfileImage();
    if (savedImage.isNotEmpty) {
      setState(() {
        profileImage = savedImage;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileImage(); // Reload profile image when dependencies change
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Consumer<WishlistProvider>(
                  builder: (_, wishlist, __) => buildAnimatedIconButton(
                    Icons.favorite_border,
                    badge: wishlist.wishlist.length.toString(),
                    onPressed: () {
                      PageNavigations().push(WishlistScreen());
                    },
                  ),
                ),
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
            ),
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
            // ListTile(
            //   leading: Container(
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.grey.withOpacity(0.2)),
            //     padding: EdgeInsets.all(8),
            //     child: Icon(
            //       Icons.wallet,
            //       color: AppColors.orange,
            //     ),
            //   ),
            //   title: Text('Payments'),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios_rounded,
            //     color: AppColors.grey,
            //   ),
            //   onTap: () {},
            // ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.location_history_outlined,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Address'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                PageNavigations().push(AddressScreen(true));
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.lock_reset_outlined,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Change Password'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                // PageNavigations().push(AddressScreen(widget.address, true, ));
              },
            ),
             ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.feedback_outlined,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Feedback'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () => _sendFeedbackEmail(),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.info_outline,
                  color: AppColors.orange,
                ),
              ),
              title: Text('About Us'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.2)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.lock_person_outlined,
                  color: AppColors.orange,
                ),
              ),
              title: Text('Privacy Policy'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
              ),
              onTap: () => _launchTermsFeed(),
            ),
            // ListTile(
            //   leading: Container(
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.grey.withOpacity(0.2)),
            //     padding: EdgeInsets.all(8),
            //     child: Icon(
            //       Icons.settings,
            //       color: AppColors.orange,
            //     ),
            //   ),
            //   title: Text('Settings'),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios_rounded,
            //     color: AppColors.grey,
            //   ),
            //   onTap: () {},
            // ),
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

void _launchTermsFeed() async {
  final Uri url = Uri.parse(
      'https://www.termsfeed.com/live/ea151a16-67c6-4131-b2e1-37794bdb7dd9');
  if (await canLaunchUrl(url)) {
    await launchUrl(url,
        mode: LaunchMode.externalApplication); // opens in browser
  } else {
    throw 'Could not launch $url';
  }
}
  void _sendFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@picknow.com',
      query: 'subject=App Feedback&body=Hi PickNow Team,%0A%0AI would like to share the following feedback...',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // fallback or error message
      debugPrint('Could not launch email app');
    }
  }
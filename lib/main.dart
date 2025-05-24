import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:picknow/core/utils/connectivity.dart';
import 'package:picknow/providers/authentication/login_provider.dart';
import 'package:picknow/providers/authentication/register_provider.dart';
import 'package:picknow/providers/cart/order.dart';
import 'package:picknow/providers/combo_provider.dart';
import 'package:picknow/providers/product/latest_product_provider.dart';
import 'package:picknow/providers/product/offer_provider.dart';
import 'package:picknow/providers/product/product_detail_provider.dart';
import 'package:picknow/providers/product/product_list_provider.dart';
import 'package:picknow/providers/profile/userprofile_provider.dart';
import 'package:picknow/providers/search/search_provider.dart';
import 'package:picknow/views/bottombar/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/costants/navigation/navigation.dart';
import 'providers/cart/address_provider.dart';
import 'providers/cart/cart_provider.dart';
import 'providers/category/all_category.dart';
import 'providers/category/sub_category.dart';
import 'providers/combo/combo_provider.dart';
import 'providers/product/related_products.dart';
import 'providers/reviewproviders/review_provider.dart';
import 'providers/whishlist/whishlist_provider.dart';
import 'views/onboading/onboading_main.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialScreen =
      const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    setState(() {
      _initialScreen = token != null ? BottomBar() : OnboardingScreen();
    });

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InternetConnectivity()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ComboListProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => RelatedProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => LatestProductProvider()),
        ChangeNotifierProvider(
          create: (_) => ComboProvider(),
        )
      ],
      child: Consumer<InternetConnectivity>(
        builder: (context, internetConnectivity, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'PickNow',
            theme: ThemeData(
              textTheme:
                  const TextTheme(titleSmall: TextStyle(color: Colors.black)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: "Lato",
            ),
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) => internetConnectivity.isConnected
                  ? _initialScreen
                  : NoInternetScreen(),
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrine/pages/account_page.dart';
import 'package:shrine/pages/cartpage.dart';
import 'package:shrine/pages/checkout_screen.dart';
import 'package:shrine/pages/favourites_page.dart';
import 'package:shrine/pages/homepage.dart';
import 'package:shrine/pages/signup_page.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/supplemental/product_methods.dart';
import 'package:shrine/supplemental/theme.dart';

import 'pages/login_page.dart';
import 'supplemental/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ShrineApp());
}

class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  @override
  Widget build(BuildContext context) {
    getProducts();
    getOrders();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shrine',
      initialRoute: loginRoute,
      routes: {
        loginRoute: (BuildContext context) => const LoginPage(),
        signupRoute: (BuildContext context) => const SignupPage(),
        homePageRoute: (BuildContext context) => const HomePage(),
        cartRoute: (BuildContext context) => const CartPage(),
        checkoutRoute: (BuildContext context) => const CheckOutPage(),
        accountRoute: (BuildContext context) => const AccountPage(),
        favouriteRoute: (BuildContext context) => const Favourites(),
      },
      theme: buildShrineTheme(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrine/pages/account_page.dart';
import 'package:shrine/pages/cartpage.dart';
import 'package:shrine/pages/checkout_screen.dart';
import 'package:shrine/pages/favourites_page.dart';
import 'package:shrine/pages/homepage.dart';
import 'package:shrine/pages/signup.dart';
import 'package:shrine/supplemental/theme.dart';

import 'pages/login.dart';
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
  FirebaseDatabase.instance.setPersistenceEnabled(true);
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
    var loginRoute = '/login';
    var signupRoute = '/signup';
    var homePageRoute = '/start';
    var cartRoute = '/cart';
    var checkoutRoute = '/checkout';
    var accountRoute = '/account';
    var favouriteRoute = '/favourites';

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

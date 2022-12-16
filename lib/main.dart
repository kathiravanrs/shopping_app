import 'package:electron_avenue/pages/account_page.dart';
import 'package:electron_avenue/pages/cartpage.dart';
import 'package:electron_avenue/pages/checkout_screen.dart';
import 'package:electron_avenue/pages/favourites_page.dart';
import 'package:electron_avenue/pages/homepage.dart';
import 'package:electron_avenue/pages/seller_page.dart';
import 'package:electron_avenue/pages/signup_page.dart';
import 'package:electron_avenue/supplemental/constants.dart';
import 'package:electron_avenue/supplemental/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  runApp(const ElectronApp());
}

class ElectronApp extends StatefulWidget {
  const ElectronApp({Key? key}) : super(key: key);

  @override
  _ElectronAppState createState() => _ElectronAppState();
}

class _ElectronAppState extends State<ElectronApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electron Avenue',
      initialRoute: loginRoute,
      routes: {
        loginRoute: (BuildContext context) => const LoginPage(),
        signupRoute: (BuildContext context) => const SignupPage(),
        homePageRoute: (BuildContext context) => const HomePage(),
        cartRoute: (BuildContext context) => const CartPage(),
        checkoutRoute: (BuildContext context) => const CheckOutPage(),
        accountRoute: (BuildContext context) => const AccountPage(),
        favouriteRoute: (BuildContext context) => const Favourites(),
        processOrderRoute: (BuildContext context) => const ProcessOrders(),
      },
      theme: buildElectronTheme(),
    );
  }
}

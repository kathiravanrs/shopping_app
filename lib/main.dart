import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrine/pages/cartpage.dart';
import 'package:shrine/pages/checkout_screen.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/signup': (BuildContext context) => const SignupPage(),
        '/start': (BuildContext context) => const HomePage(),
        '/cart': (BuildContext context) => const CartPage(),
        '/checkout': (BuildContext context) => const CheckOutPage(),
      },
      theme: buildShrineTheme(),
    );
  }
}

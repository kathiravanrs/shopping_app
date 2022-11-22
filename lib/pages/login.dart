import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // register(String email, String pass, BuildContext context) async {
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //           email: email, password: pass)
  //       .then((value) => {
  //             ScaffoldMessenger.of(context)
  //                 .showSnackBar(const SnackBar(content: Text("Registered")))
  //           });
  // }

  // loginCheck() async {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       if (kDebugMode) {
  //         print(user.uid);
  //       }
  //       Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
  //     }
  //   });
  // }

  // login() async {
  //   String email = emailController.text;
  //   String password = passwordController.text;
  //   if (email.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("Email can't be blank")));
  //   } else if (password.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("Password can't be blank")));
  //   } else {
  //     FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((value) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged In!")));
  //       Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
  //     }).catchError((err) {
  //       if (kDebugMode) {
  //         print(err.message);
  //       }
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: const Text("Something went wrong!"),
  //               content: Text(err.message),
  //               actions: [
  //                 TextButton(
  //                     child: const Text("Ok"),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     }),
  //               ],
  //             );
  //           });
  //     });
  //   }
  // }
  //
  // logout() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool("LoggedIn", false);
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged Out!")));
  // }

  @override
  Widget build(BuildContext context) {
    loginCheck(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('SIGN UP'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/signup', (route) => false);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('LOGIN'),
                  onPressed: () {
                    // register();
                    login(emailController.text, passwordController.text, context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

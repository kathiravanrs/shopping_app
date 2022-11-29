import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';

import '../supplemental/auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var modal = Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 200,
        color: kShrinePink50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: resetPasswordController,
                  decoration: const InputDecoration(hintText: "Enter your email"),
                ),
              ),
              ElevatedButton(
                child: const Text('Reset Password'),
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: resetPasswordController.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );

    loginCheck(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPaddin),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 80.0),
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
                      elevation: 2.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return modal;
                          });
                      // showDialog(context: context, builder: (context){
                      //
                      // });
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(color: kShrineBrown900, fontSize: 12),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

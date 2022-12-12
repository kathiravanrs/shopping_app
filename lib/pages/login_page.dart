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
    var resetPassDialog = AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      title: const Text("Reset Password"),
      content: TextField(
        controller: resetPasswordController,
        decoration: const InputDecoration(
          hintText: "Enter your email",
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.secondary,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('SUBMIT'),
          onPressed: () async {
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: resetPasswordController.text);
            resetPasswordController.clear();
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Password Reset Email Sent")));
          },
        ),
      ],
    );

    loginCheck(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
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
                      Navigator.pushNamedAndRemoveUntil(
                          context, signupRoute, (route) => false);
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
                      login(emailController.text, passwordController.text,
                          context);
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
              const SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return resetPassDialog;
                        });
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(color: kShrineBrown900, fontSize: 12),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

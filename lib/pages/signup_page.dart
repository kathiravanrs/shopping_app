import 'package:electron_avenue/supplemental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  register() async {
    String email = emailController.text;
    String password = passController.text;
    String confirmPass = confirmPassController.text;

    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    if (confirmPass.compareTo(password) != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Passwords doesn't match! Check again.")));
    } else {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        // DatabaseReference ref = r.push();
        ref.child(value.user!.uid).set({
          "firstName": firstName,
          "lastName": lastName,
          "phone": phone,
          "email": email
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("New User Registered!")));
          Navigator.pushNamedAndRemoveUntil(
              context, homePageRoute, (route) => false);
        });
      }).catchError((err) {
        if (kDebugMode) {
          print(err.message);
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Something went wrong!"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'ELECTRON AVENUE',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: passController,
              decoration: const InputDecoration(
                labelText: 'Choose a strong password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: confirmPassController,
              decoration: const InputDecoration(
                labelText: 'Confirm password',
              ),
              obscureText: true,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Back to login'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('SIGNUP'),
                  onPressed: () {
                    register();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
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

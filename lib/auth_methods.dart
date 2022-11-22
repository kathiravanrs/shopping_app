import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

register(String email, String pass, BuildContext context) async {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((value) {
    return {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New User registered")),
      )
    };
  });
}

loginCheck(BuildContext context) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      if (kDebugMode) {
        print(user.uid);
      }
      Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
    }
  });
}

login(String email, String password, BuildContext context) async {
  if (email.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Email can't be blank")));
  } else if (password.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Password can't be blank")));
  } else {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged In!")));
      Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
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
                    }),
              ],
            );
          });
    });
  }
}

logout(BuildContext context) async {
  FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("LoggedIn", false);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged Out!")));
}

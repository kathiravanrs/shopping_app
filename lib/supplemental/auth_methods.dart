import 'package:electron_avenue/supplemental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/user_details.dart';

register(String email, String pass, BuildContext context) async {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: pass)
      .then((value) {
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
      userID = user.uid;
      if (kDebugMode) {
        print(user.uid);
      }
      Navigator.pushNamedAndRemoveUntil(
          context, homePageRoute, (route) => false);
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Logged In!")));
      Navigator.pushNamedAndRemoveUntil(
          context, homePageRoute, (route) => false);
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
  Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);

  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Logged Out!")));
}

deleteUser(User user, BuildContext context) async {
  await FirebaseDatabase.instance.ref("users/$userID").remove();
  await FirebaseDatabase.instance.ref("favourites/$userID").remove();
  await FirebaseDatabase.instance.ref("orders/$userID").remove();
  await FirebaseDatabase.instance.ref("cart/$userID").remove();
  await user.delete().then((value) {
    Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Logged Out!")));
  });
}

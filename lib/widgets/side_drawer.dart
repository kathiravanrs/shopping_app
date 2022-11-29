import 'package:flutter/material.dart';

import '../supplemental/auth_methods.dart';
import '../supplemental/constants.dart';
import '../supplemental/user_details.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kShrinePink50,
            ),
            child: Center(child: Text('Greetings $firstName')),
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Favourites'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('SIGN OUT'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

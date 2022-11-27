import 'package:flutter/material.dart';

import '../supplemental/auth_methods.dart';
import '../supplemental/constants.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kShrinePink50,
            ),
            child: Center(child: Text('Greetings User')),
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

import 'package:flutter/material.dart';

import '../data/user_details.dart';
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, accountRoute);
            },
          ),
          ListTile(
            title: const Text('Favourites'),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, favouriteRoute);
            },
          ),
          if (email == "admin@email.com")
            ListTile(
              title: const Text('Process Orders'),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, processOrderRoute);
              },
            ),
          ListTile(
            title: const Text('SIGN OUT'),
            onTap: () {
              Navigator.pop(context);
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

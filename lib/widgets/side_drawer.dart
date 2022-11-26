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
            child: Center(child: Text('Header')),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          // Spacer(flex: ),
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

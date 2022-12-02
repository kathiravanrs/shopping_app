import 'package:flutter/material.dart';
import 'package:shrine/pages/tabs/home_tab.dart';
import 'package:shrine/pages/tabs/search_tab.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/side_drawer.dart';

import 'tabs/orders_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var homeAppBar = AppBar(
      bottom: const TabBar(
        labelColor: kShrineBrown900,
        tabs: [
          Tab(
              icon: Icon(
            Icons.home_filled,
          )),
          Tab(
              icon: Icon(
            Icons.search,
          )),
          Tab(
              icon: Icon(
            Icons.shopping_bag,
          )),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      title: const Text("SHRINE"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            semanticLabel: 'shopping cart',
          ),
          onPressed: () {
            Navigator.pushNamed(context, cartRoute);
          },
        ),
      ],
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const SideDrawer(),
        appBar: homeAppBar,
        body: const TabBarView(
          children: [
            HomeTab(),
            SearchTab(),
            OrdersTab(),
          ],
        ),
      ),
    );
  }
}

import 'package:electron_avenue/pages/tabs/home_tab.dart';
import 'package:electron_avenue/pages/tabs/search_tab.dart';
import 'package:electron_avenue/supplemental/constants.dart';
import 'package:electron_avenue/widgets/side_drawer.dart';
import 'package:flutter/material.dart';

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
        labelColor: kElectronBrown900,
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
            Icons.receipt_long,
          )),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      title: const Text("ELECTRON AVENUE"),
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

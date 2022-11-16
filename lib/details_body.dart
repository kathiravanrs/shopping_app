import 'package:flutter/material.dart';

import 'constants.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                      // children: <Widget>[
                      //   ColorAndSize(
                      //     product: product,
                      //     key: const Key('fsb'),
                      //   ),
                      //   const SizedBox(height: kDefaultPaddin / 2),
                      //   Description(
                      //     product: product,
                      //     key: const Key("sbmn"),
                      //   ),
                      //   const SizedBox(height: kDefaultPaddin / 2),
                      //   const CounterWithFavBtn(
                      //     key: Key("F"),
                      //   ),
                      //   const SizedBox(height: kDefaultPaddin / 2),
                      //   AddToCart(
                      //     product: product,
                      //     key: const Key("h"),
                      //   )
                      // ],
                      ),
                ),
                // ProductTitleWithImage(
                //   product: product,
                //   key: const Key("fnvjs"),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

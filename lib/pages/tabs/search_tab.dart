import 'package:flutter/material.dart';

import '../../supplemental/constants.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Headphones",
      "Laptop",
      "PC",
      "Accessories",
      "Smartphones",
      "Cameras",
      "Smart Home",
      "Speakers",
      "Wearables",
      "TV"
    ];
    categories.sort();

    var search = Padding(
      padding: const EdgeInsets.all(kDefaultPaddin),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(hintText: "Search for products"),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "CATEGORIES",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio:
                      MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
                ),
                itemBuilder: (context, index) {
                  return TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: kShrineBrown900, backgroundColor: kShrinePink100),
                    child: Text(
                      categories[index].toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                  );
                },
              ),
            ),
          )
        ],
      ),
    );

    return search;
  }
}

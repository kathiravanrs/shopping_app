import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/pages/tabs/home_tab.dart';
import 'package:shrine/supplemental/theme.dart';

import '../../supplemental/constants.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = "";
  final searchController = TextEditingController();
  String selectedCategory = "";

  void textListener() {
    setState(() {
      query = searchController.text;
    });
    print(query);
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(textListener);
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Headphones",
      "Laptop",
      "PC",
      "Accessories",
      "Smartphones",
      "Camera",
      "Smart Home",
      "Speakers",
      "Wearables",
      "TV",
    ];
    categories.sort();

    var categoryGrid = Visibility(
      visible: selectedCategory.isEmpty,
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPadding,
              crossAxisSpacing: kDefaultPadding,
              childAspectRatio: MediaQuery.of(context).size.height /
                  (MediaQuery.of(context).size.width),
            ),
            itemBuilder: (context, index) {
              return TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: kShrineBrown900,
                    backgroundColor: kShrinePink100),
                child: Text(
                  categories[index].toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    selectedCategory = categories[index].toLowerCase();
                  });
                },
              );
            },
          ),
        ),
      ),
    );

    var searchField = Visibility(
        visible: selectedCategory.isEmpty,
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(hintText: "Search for products"),
        ));

    var categoryText = Visibility(
      visible: query.isEmpty && selectedCategory.isEmpty,
      child: const Center(
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
    );

    var searchText = Visibility(
      visible: query.isNotEmpty && selectedCategory.isEmpty,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Products matching the term:",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );

    var searchProductsWithQuery = Visibility(
      visible: query.isNotEmpty && selectedCategory.isEmpty,
      child: Expanded(
        child: ProductGrid(
            products: products
                .where((element) =>
                    element.title.toLowerCase().contains(query.toLowerCase()))
                .toList()),
      ),
    );

    var searchWithCategory = Visibility(
      visible: selectedCategory.isNotEmpty,
      child: Expanded(
        child: Column(children: [
          const Line(),
          Expanded(
            child: ProductGrid(
                products: products
                    .where((element) => element.category
                        .toLowerCase()
                        .contains(selectedCategory.toLowerCase()))
                    .toList()),
          )
        ]),
      ),
    );

    var categoryBar = Visibility(
      visible: selectedCategory.isNotEmpty,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Showing only:",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = "";
                  });
                },
                child: Row(
                  children: [
                    Text(
                      selectedCategory.toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.cancel_outlined)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          categoryBar,
          searchField,
          categoryText,
          categoryGrid,
          searchText,
          searchProductsWithQuery,
          searchWithCategory,
        ],
      ),
    );
  }
}

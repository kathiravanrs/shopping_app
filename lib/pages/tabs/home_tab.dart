import 'package:electron_avenue/supplemental/product_methods.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';
import '../../supplemental/constants.dart';
import '../../widgets/product_grid.dart';

enum SortBy {
  alphabetical,
  alphabeticalReverse,
  priceHighToLow,
  priceLowToHigh
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  double priceMin = double.negativeInfinity;
  double priceMax = double.infinity;

  SortBy sortBy = SortBy.priceLowToHigh;

  List<Product> filter(List<Product> p, double min, double max) {
    return p
        .where((element) => element.price <= max && element.price >= min)
        .toList();
  }

  List<Product> customSort(List<Product> p, SortBy sortBy) {
    if (sortBy == SortBy.alphabetical) {
      p.sort((a, b) => a.title.compareTo(b.title));
    } else if (sortBy == SortBy.alphabeticalReverse) {
      p.sort((a, b) => b.title.compareTo(a.title));
    } else if (sortBy == SortBy.priceLowToHigh) {
      p.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == SortBy.priceHighToLow) {
      p.sort((a, b) => b.price.compareTo(a.price));
    }
    return p;
  }

  final minController = TextEditingController();
  final maxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String sortText = "A to Z";
    if (sortBy == SortBy.alphabeticalReverse) sortText = "Z to A";
    if (sortBy == SortBy.priceLowToHigh) sortText = "Low to High";
    if (sortBy == SortBy.priceHighToLow) sortText = "High to Low";

    String filterText = "No Price Range Set";
    if (priceMin == double.negativeInfinity && priceMax != double.infinity) {
      filterText = "Below \$$priceMax";
    }
    if (priceMin != double.negativeInfinity && priceMax == double.infinity) {
      filterText = "Above \$$priceMin";
    }
    if (priceMin != double.negativeInfinity && priceMax != double.infinity) {
      filterText = "\$$priceMin to \$$priceMax";
    }

    var filterDialog = AlertDialog(
      title: Center(child: Text("Filter price".toUpperCase())),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: TextField(
                keyboardType: TextInputType.number,
                controller: minController,
                decoration: const InputDecoration(
                  hintText: "Minimum",
                )),
          ),
          const SizedBox(width: 30),
          const Text("TO"),
          const SizedBox(width: 30),
          SizedBox(
            width: 100,
            child: TextField(
                keyboardType: TextInputType.number,
                controller: maxController,
                decoration: const InputDecoration(
                  hintText: "Maximum",
                )),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('RESET'),
          onPressed: () {
            setState(() {
              priceMin = double.negativeInfinity;
              priceMax = double.infinity;
            });
            minController.clear();
            maxController.clear();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.secondary,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('APPLY'),
          onPressed: () {
            setState(() {
              if (minController.text.isEmpty) {
                priceMin = double.negativeInfinity;
              } else {
                priceMin = double.parse(minController.text);
              }
              if (maxController.text.isEmpty) {
                priceMax = double.infinity;
              } else {
                priceMax = double.parse(maxController.text);
              }
            });
            Navigator.pop(context);
          },
        ),
      ],
    );

    var sortDialog = AlertDialog(
      title: Center(child: Text("SORT BY: ".toUpperCase())),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<SortBy>(
            title: const Text('Name: A -> Z'),
            value: SortBy.alphabetical,
            groupValue: sortBy,
            onChanged: (SortBy? value) {
              setState(() {
                sortBy = value!;
              });
              Navigator.pop(context);
            },
          ),
          RadioListTile<SortBy>(
            title: const Text('Name: Z -> A'),
            value: SortBy.alphabeticalReverse,
            groupValue: sortBy,
            onChanged: (SortBy? value) {
              setState(() {
                sortBy = value!;
              });
              Navigator.pop(context);
            },
          ),
          RadioListTile<SortBy>(
            title: const Text('Price: Low to High'),
            value: SortBy.priceLowToHigh,
            groupValue: sortBy,
            onChanged: (SortBy? value) {
              setState(() {
                sortBy = value!;
              });
              Navigator.pop(context);
            },
          ),
          RadioListTile<SortBy>(
            title: const Text('Price High To Low'),
            value: SortBy.priceHighToLow,
            groupValue: sortBy,
            onChanged: (SortBy? value) {
              setState(() {
                sortBy = value!;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context, builder: (ctx) => filterDialog);
                  },
                  child: Row(
                    children: [
                      Text(filterText),
                      const SizedBox(width: 10),
                      const Icon(Icons.filter_alt),
                    ],
                  )),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (ctx) => sortDialog);
                  },
                  child: Row(
                    children: [
                      Text(sortText),
                      const SizedBox(width: 10),
                      if (sortBy == SortBy.alphabetical ||
                          sortBy == SortBy.priceLowToHigh)
                        Transform.scale(
                            scaleY: -1, child: const Icon(Icons.sort)),
                      if (sortBy == SortBy.alphabeticalReverse ||
                          sortBy == SortBy.priceHighToLow)
                        const Icon(Icons.sort),
                    ],
                  )),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data!;
                  products = customSort(products, sortBy);
                  products = filter(products, priceMin, priceMax);
                  return ProductGrid(products: products);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

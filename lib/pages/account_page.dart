import 'package:flutter/material.dart';
import 'package:shrine/data/user_details.dart';

import '../model/address.dart';
import '../supplemental/constants.dart';
import '../supplemental/product_methods.dart';
import '../widgets/address_item.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final userFirstName = TextEditingController(text: firstName);
    final userLastName = TextEditingController(text: lastName);
    final userEmail = TextEditingController(text: email);
    final userPhone = TextEditingController(text: phone);
    final userPhoneCountry = TextEditingController(text: "+ 1");

    final addressFirstName = TextEditingController();
    final addressLastName = TextEditingController();
    final addressStreet = TextEditingController();
    final addressCity = TextEditingController();
    final addressState = TextEditingController();
    final addressZIP = TextEditingController();
    final addressPhone = TextEditingController();

    var addAddressDialog = AlertDialog(
      title: Center(child: Text("Add New Address".toUpperCase())),
      content: SizedBox(
        height: 350,
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addressFirstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "First Name",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: addressLastName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "Last Name",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            TextField(
              controller: addressStreet,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "Street Address",
                    style: TextStyle(color: kShrineBrown900, fontSize: 12),
                  )),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addressCity,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "City",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: addressState,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "State",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: addressZIP,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "ZIP",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: addressPhone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "Phone",
                          style:
                              TextStyle(color: kShrineBrown900, fontSize: 12),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(20),
                    backgroundColor: kShrinePink50,
                    foregroundColor: kShrineBrown900),
                onPressed: () {
                  if (addressFirstName.text.isEmpty ||
                      addressLastName.text.isEmpty ||
                      addressStreet.text.isEmpty ||
                      addressCity.text.isEmpty ||
                      addressState.text.isEmpty ||
                      addressZIP.text.isEmpty ||
                      addressPhone.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Fill All Fields To Add")));
                  } else {
                    Address address = Address(
                        addID: getRandomString(10),
                        firstName: addressFirstName.text,
                        lastName: addressLastName.text,
                        streetAddress: addressStreet.text,
                        city: addressCity.text,
                        state: addressState.text,
                        zip: int.parse(addressZIP.text),
                        phone: addressPhone.text);
                    saveAddress(address);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
    var addressPickerDialog = StatefulBuilder(
      builder: ((context, setState) {
        int chosenAddress = 0;
        return AlertDialog(
          title: Center(child: Text("Saved Address".toUpperCase())),
          content: SizedBox(
            height: 350,
            width: 300,
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            chosenAddress = index;
                            selectedAddress = addresses[chosenAddress];
                          });
                        },
                        child: AddressItem(
                          address: addresses[index],
                          isSelected: chosenAddress == index,
                        ),
                      );
                    }),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kShrinePink50,
                        foregroundColor: kShrineBrown900),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context, builder: (ctx) => addAddressDialog);
                    },
                    child: const Text("Add New Address")),
              ],
            ),
          ),
        );
      }),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Account Details")),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: userFirstName,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        "First Name",
                                        style: TextStyle(
                                            color: kShrineBrown900,
                                            fontSize: 12),
                                      )),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  controller: userLastName,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        "Last Name",
                                        style: TextStyle(
                                            color: kShrineBrown900,
                                            fontSize: 12),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: userEmail,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text(
                                  "Email Address",
                                  style: TextStyle(
                                      color: kShrineBrown900, fontSize: 12),
                                )),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  controller: userPhoneCountry,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        "Country",
                                        style: TextStyle(
                                            color: kShrineBrown900,
                                            fontSize: 12),
                                      )),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  controller: userPhone,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                            color: kShrineBrown900,
                                            fontSize: 12),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kShrinePink50,
                          foregroundColor: kShrineBrown900),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => addressPickerDialog);
                      },
                      child: const Text("See Addresses"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kShrinePink300,
                          foregroundColor: kShrineBrown900),
                      onPressed: () {},
                      child: const Text("Confirm"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Address {
  String addID;
  String firstName;
  String lastName;
  String streetAddress;
  String city;
  String state;
  int zip;
  String phone;

  Address({
    required this.addID,
    required this.firstName,
    required this.lastName,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zip,
    required this.phone,
  });

  @override
  String toString() {
    return 'Address{addID: $addID, firstName: $firstName, lastName:'
        ' $lastName, streetAddress: $streetAddress, city: $city,'
        ' state: $state, zip: $zip, phone: $phone}';
  }
}

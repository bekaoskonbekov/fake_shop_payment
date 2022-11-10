class User {
  final String id;
  final Name name;
  final String email;
  final String password;
  final String phone;
  final Address address;

  const User({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
  });
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});
}

class Address {
  final String city;
  final String street;
  final String number;
  final String zipcode;

  Address(
      {required this.city,
      required this.street,
      required this.number,
      required this.zipcode});
}

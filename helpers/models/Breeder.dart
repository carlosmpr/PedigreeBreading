import 'package:uuid/uuid.dart';

var uuid = Uuid();

class UserBreeder {
  final String userType;
  String userId;
  String username;
  String lastname;
  final email;
  final String dogId = uuid.v4();

  UserBreeder(this.userType, this.email);
}

class Dog {
  final String dogId;
  String zipcode = "";
  String dogname;
  String gender;
  String tempered;
  String breederType;
  String bio;
  String age;
  String imageUrl1 = "";
  String imageUrl2 = "";
  String imageUrl3 = "";
  String imageUrl4 = "";

  Dog(
    this.dogId,
  );
}

class DogResponse {
  final List<Dog> info;

  DogResponse(this.info);
}

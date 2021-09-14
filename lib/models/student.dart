class Student {
  String firstName;
  String surname;
  String lastName;
  String email;
  String gender;
  String matricNumber;
  String session;
  String phoneNumber;
  String address;
  String name;
  String fullName;

  Student({
    this.address,
    this.email,
    this.firstName,
    this.surname,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.matricNumber,
    this.session,
    this.fullName,
    this.name,
  });

  Student.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    surname = json["surname"];
    lastName = json["lastName"];
    email = json["email"];
    phoneNumber = json["phone"];
    gender = json["gender"];
    matricNumber = json["matric_number"];
    session = json["seesion"];
    address = json["address"];
    fullName =
        json["firstName"] + " " + json["lastName"] + " " + json["surname"];
    name = json["firstName"] + " " + json["surname"];
  }
}

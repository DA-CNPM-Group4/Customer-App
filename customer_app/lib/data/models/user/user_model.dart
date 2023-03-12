class UserModel {
  int? id;
  String? homeAddress;
  bool? gender;
  String? phoneNumber;
  String? email;
  String? fullName;

  UserModel(
      {id,
        homeAddress,
        gender,
        phoneNumber,
        email,
        fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    homeAddress = json['homeAddress'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['homeAddress'] = homeAddress;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['fullName'] = fullName;
    return data;
  }
}
class UserModel {
  String? id;
  bool? gender;
  String? phone;
  String? email;
  String? name;

  UserModel({id, homeAddress, gender, phoneNumber, email, fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    phone = json['phoneNumber'];
    email = json['email'];
    name = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gender'] = gender;
    data['phone'] = phone;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}

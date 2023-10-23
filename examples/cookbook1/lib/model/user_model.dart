class DataModel {
  DataModel({
    this.name,
    this.email,
    this.password,
    this.uid,
    this.phone,
  });

  late final String? name;
  late final String? email;
  late final String? password;
  late final String? uid;
  late final String? phone;

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': uid,
      'phone': phone,
    };
  }
}

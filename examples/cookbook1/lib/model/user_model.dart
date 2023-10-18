
class DataModel {
  DataModel({
    this.name,
    this.email,
    this.uid,
    this.phone,

    
  });

 late final String? name;
  late final String? email;
  late final String? uid;
  late final String? phone;

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
       'address': uid,
       'phone': phone,

    };
  }
}

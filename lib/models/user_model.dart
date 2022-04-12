class UserModel {
  int id;
  String name;
  String email;
  String username;
  String token;
  String image;

  UserModel(
      {this.email, this.id, this.name, this.token, this.username, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
    image =
        "https://ui-avatars.com/api/?name=${json['name']}&color=187EE2&background=D1E6FA";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'image': image,
      'token': token,
    };
  }
}

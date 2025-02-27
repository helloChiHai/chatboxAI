class User {
  final String id;
  final String userName;
  final String email;
  final String token;
  final String img;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.token,
    required this.img,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'token': token,
    };
  }
}

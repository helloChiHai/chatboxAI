// class UserInformationModel {
//   final String height;
//   final String weight;
//   final String income;
//   final String age;

//   UserInformationModel({
//     required this.height,
//     required this.weight,
//     required this.income,
//     required this.age,
//   });

//   factory UserInformationModel.fromJson(Map<String, dynamic> json) {
//     return UserInformationModel(
//       height: json['height'],
//       weight: json['weight'],
//       income: json['income'],
//       age: json['age'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'height': height,
//       'weight': weight,
//       'income': income,
//       'age': age,
//     };
//   }

//   @override
//   String toString() {
//     return 'UserInformationModel(height: $height, weight: $weight, income: $income, age: $age)';
//   }
// }

class UserInformationModel {
  final String height;
  final String weight;
  final String income;
  final String age;

  UserInformationModel({
    required this.height,
    required this.weight,
    required this.income,
    required this.age,
  });

  factory UserInformationModel.fromJson(Map<String, dynamic> json) {
    return UserInformationModel(
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      income: json['income'].toString(),
      age: json['age'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'income': income,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'UserInformationModel(height: $height, weight: $weight, income: $income, age: $age)';
  }
}

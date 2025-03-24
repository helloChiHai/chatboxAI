class Question {
  final String key;
  final String text;
  final List<String> options;
  String? selectedOption;

  Question(
      {required this.key,
      required this.text,
      required this.options,
      this.selectedOption});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'text': text,
      'options': options,
      'selectedOption': selectedOption,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      key: json['key'],
      text: json['text'],
      options: json['options'],
    );
  }
}

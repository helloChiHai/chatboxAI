class Question {
  final String key;
  final String text;
  final List<String> options;
  String? selectedOption;
  int starCount = 0;

  Question({
    required this.key,
    required this.text,
    required this.options,
    this.selectedOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      key: json['key'].toString(),
      text: json['text'],
      options: List<String>.from(json['options']),
      selectedOption: json['selectedOption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'text': text,
      'options': options,
      'selectedOption': selectedOption,
    };
  }
}

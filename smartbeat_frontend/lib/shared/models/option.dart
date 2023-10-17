class Option {
  final String value;
  final String text;

  const Option({
    required this.value,
    required this.text,
  });

  Map<String, dynamic> toMap() => {
    'value': value,
    'text': text,
  };

  Option.from(Map<String, dynamic> data)
      : value = data['value'],
        text = data['text'];
}

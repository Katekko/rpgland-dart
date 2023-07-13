class CustomMessage {
  int timestamp;

  String name;
  String body;
  bool isGroup;

  String? phone;
  String? telegramId;

  String? groupTitle;

  Map<String, void Function(dynamic)> callbacks;

  CustomMessage({
    required this.timestamp,
    required this.body,
    required this.name,
    required this.isGroup,
    required this.callbacks,
    this.telegramId,
    this.phone,
  });
}

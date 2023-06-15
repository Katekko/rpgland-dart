class CustomMessage {
  int timestamp;

  String name;
  String body;
  void Function(String message) reply;
  bool isGroup;

  String? phone;
  String? telegramId;

  CustomMessage({
    required this.timestamp,
    required this.body,
    required this.reply,
    required this.name,
    required this.isGroup,
    this.telegramId,
    this.phone,
  });
}

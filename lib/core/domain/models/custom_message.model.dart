class CustomMessage {
  int timestamp;
  String phone;
  String name;
  String body;
  void Function(String message) reply;
  bool isGroup;

  CustomMessage({
    required this.timestamp,
    required this.phone,
    required this.body,
    required this.reply,
    required this.name,
    required this.isGroup,
  });
}

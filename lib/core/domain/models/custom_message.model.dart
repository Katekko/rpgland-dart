import 'package:teledart/model.dart';

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

  factory CustomMessage.fromTelegramMessage(TeleDartMessage msg) {
    final customMessage = CustomMessage(
      body: msg.text ?? '',
      telegramId: msg.from?.id.toString(),
      timestamp: msg.date,
      isGroup: msg.chat.type == Chat.typeGroup,
      name: msg.chat.firstName ?? '',
      reply: msg.reply,
      phone: msg.contact?.phoneNumber.replaceAll('+', ''),
    );

    return customMessage;
  }
}

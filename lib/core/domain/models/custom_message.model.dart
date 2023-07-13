import 'package:simple_whatsapp_bot/simple_whatsapp_bot.dart';
import 'package:teledart/model.dart';

class CustomMessage {
  int timestamp;

  String name;
  String body;
  void Function(String message) reply;
  void Function(String message) sendMessage;
  bool isGroup;

  String? phone;
  String? telegramId;

  CustomMessage({
    required this.timestamp,
    required this.body,
    required this.reply,
    required this.name,
    required this.isGroup,
    required this.sendMessage,
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
      phone: msg.contact?.phoneNumber.replaceAll('+', ''),
      reply: msg.reply,
      sendMessage: (msg) {},
    );

    return customMessage;
  }

  factory CustomMessage.fromWhatsappMessage({
    required WhatsAppMessage message,
    required SimpleWhatsAppClient client,
  }) {
    final customMessage = CustomMessage(
      timestamp: message.timestamp,
      body: message.body,
      name: message.owner.name,
      isGroup: message.isFromGroup,
      reply: (msg) => client.chat.sendReplyTextMessage(
        message: msg,
        messageToReply: message,
      ),
      sendMessage: (msg) => client.chat.sendTextMessage(
        chatId: message.chatId,
        message: msg,
      ),
    );

    return customMessage;
  }
}

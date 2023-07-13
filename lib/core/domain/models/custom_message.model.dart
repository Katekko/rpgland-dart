import 'package:simple_whatsapp_bot/simple_whatsapp_bot.dart';
import 'package:teledart/model.dart';

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

  factory CustomMessage.fromTelegramMessage(TeleDartMessage msg) {
    final callbacks = {'reply': (message) => msg.reply(message)};

    final customMessage = CustomMessage(
      body: msg.text ?? '',
      telegramId: msg.from?.id.toString(),
      timestamp: msg.date,
      isGroup: msg.chat.type == Chat.typeGroup,
      name: msg.chat.firstName ?? '',
      phone: msg.contact?.phoneNumber.replaceAll('+', ''),
      callbacks: callbacks,
    );

    return customMessage;
  }

  factory CustomMessage.fromWhatsappMessage({
    required WhatsAppMessage message,
    required SimpleWhatsAppClient client,
  }) {
    void reply(msg) => client.chat.sendReplyTextMessage(
          message: msg,
          messageToReply: message,
        );

    void sendMessage(msg) => client.chat.sendTextMessage(
          chatId: message.chatId,
          message: msg,
        );

    void setTitle(msg) => client.group.setGroupTitle(
          chatId: message.chatId,
          title: msg,
        );

    final callbacks = {
      'reply': reply,
      'sendMessage': sendMessage,
      'setTitle': setTitle
    };

    final customMessage = CustomMessage(
      timestamp: message.timestamp,
      body: message.body,
      name: message.owner.name,
      isGroup: message.isFromGroup,
      callbacks: callbacks,
    );

    return customMessage;
  }
}

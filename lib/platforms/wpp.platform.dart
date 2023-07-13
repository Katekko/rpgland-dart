import 'dart:typed_data';

import 'package:simple_whatsapp_bot/simple_whatsapp_bot.dart';

import '../core/data/services/players.service.dart';
import '../core/domain/models/custom_message.model.dart';
import '../core/injector.dart';
import '../handle_messages.dart';
import 'base_platform.dart';

class WppPlatform extends BasePlatform {
  void handleMessages(WhatsAppMessage msg, SimpleWhatsAppClient client) async {
    final customMessage = CustomMessage.fromWhatsappMessage(
      message: msg,
      client: client,
    );

    final playersService = Injector.find<PlayersService>();
    final handler = HandleMessages(
      message: customMessage,
      commandChar: '!',
      playersService: playersService,
    );

    await handler.handle();
  }

  @override
  Future<void> initiate() async {
    final client = await SimpleWhatsAppBot.connect(
      sessionDirectory: './.local-chromium/session/',
      onConnectionEvent: (ConnectionEventEnum event) {
        print(event.toString());
      },
      onQrCode: (String qr, Uint8List? imageBytes) {
        final qrText = WhatsAppBotUtils.convertStringToQrCode(qr);
        print(qrText);
      },
    );

    client.onReceiveMessage((msg) => handleMessages(msg, client));
  }
}

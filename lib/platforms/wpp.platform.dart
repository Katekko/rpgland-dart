import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'dart:typed_data';
import 'base_platform.dart';

class WppPlatform extends BasePlatform {
  @override
  Future<void> initiate() async {
    final whatsappClient = await WhatsappBotFlutter.connect(
      headless: true,
      sessionDirectory: p.join(
        Directory.current.path,
        '.local-chromium/session',
      ),
      onConnectionEvent: (ConnectionEvent event) {
        print(event.toString());
      },
      onQrCode: (String qr, Uint8List? imageBytes) {
        final qrcode = WhatsappBotUtils.convertStringToQrCode(qr);
        print(qrcode);
      },
    );

    whatsappClient?.messageEvents.listen((message) {
      print(message.body);
    });

    whatsappClient?.connectionEventStream.listen((event) {
      print(event);
    });

    await whatsappClient?.disconnect();
  }
}

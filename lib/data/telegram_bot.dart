import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class TelegramBot {
  static const String _botToken = String.fromEnvironment("TELEGRAM_BOT_TOKEN");

  static Future<void> sendMessage(String message, int chatID, int? threadID) async {
    final data = {"text": message, "chat_id": chatID.toString(), "parse_mode": "MarkdownV2"};
    if (threadID != null) {
      data.addEntries([MapEntry('message_thread_id', threadID.toString())]);
    }
    try {
      await http.post(Uri.parse("https://api.telegram.org/bot$_botToken/sendMessage"), body: data);
    } catch (e) {
      log(e.toString());
    }
  }

  static String _welcomeMessage(int chatID, int? threadID) =>
      'Всем привет, я \\- бот\\, который помогает вести очереди\nЯ буду уведомлять вас о старте новой очереди\\, приводить ссылку на регистрацию в ней\nID данного чата которое надо передать приложению: `${chatID.toString()}${threadID != null ? " ${threadID.toString()}" : ""}`';
  static Future<void> start() async {
    final result = await http.post(Uri.parse("https://api.telegram.org/bot$_botToken/getUpdates"));
    if (result.statusCode == 200) {
      final body = json.decode(result.body);
      for (final entry in body["result"]) {
        final message = entry["message"];
        if (message == null) continue;
        int chatID = message["chat"]["id"];
        final threadID = message['message_thread_id'];
        if (message["text"] == "/start" || message["text"] == '/start@StudentQueueBot') {
          await sendMessage(_welcomeMessage(chatID, threadID), chatID, threadID);
        }
      }
    }
  }
}

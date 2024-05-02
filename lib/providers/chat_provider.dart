import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import '../repositories/chat_repository.dart';

class ChatContextProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [
    ChatMessageModel(
        text:
            "You are ShaktiBot, a text based chatbot which will help people by giving them remedies to their disease symptoms. You will not answer anything other than medical questions.",
        role: "user"),
    ChatMessageModel(
        text:
            "I am ShaktiBot, a text-based chatbot designed to provide information and guidance on various medical topics. I am here to assist you with your medical queries. Please feel free to ask your question.",
        role: "model"),
    ChatMessageModel(
        text:
            "If the chat is off topic, you will say \"Sorry, but I only have knowledge regarding medical domain. I cannot assist you with this query\" and nothing else",
        role: "user"),
    ChatMessageModel(
        text:
            "Understood. If the chat goes off-topic, I will respond with the following statement:  **\"Sorry, but I only have knowledge regarding the medical domain. I cannot assist you with this query.\"**I will not generate any additional responses beyond this statement.",
        role: "model"),
  ];
  final ChatRepository chatRepository = ChatRepository();

  List<ChatMessageModel> get messages => _messages;

  void getResponse(String message) async {
    _messages.add(
      ChatMessageModel(
        text: message,
        role: 'user',
      ),
    );
    notifyListeners();
    final context = _messages.map((e) => e.toJson()).toList();
    debugPrint(context.toString());
    _messages.add(
      ChatMessageModel(
        text: "Thinking...",
        role: 'model',
      ),
    );
    final response = await chatRepository.generateContent(context);
    _messages.last = ChatMessageModel(
      text: response,
      role: 'model',
    );
    debugPrint(response);
    notifyListeners();
  }
}

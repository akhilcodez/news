import 'package:flutter/material.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/repositories/chatbot_repository.dart';

class ChatBotProvider extends ChangeNotifier {
  final ChatBotRepository _repository = ChatBotRepository();

  final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      text: "Namaste! I am your AgroWorld AI Farming Guide. How can I help your crops, soil, seeds, or farm today?",
      isUser: false,
    ),
  ];

  bool _isTyping = false;

  List<ChatMessageModel> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(ChatMessageModel(text: text.trim(), isUser: true));
    _isTyping = true;
    notifyListeners();

    try {
      final reply = await _repository.getReply(text.trim());
      _messages.add(ChatMessageModel(text: reply, isUser: false));
    } catch (_) {
      _messages.add(
        ChatMessageModel(
          text: "I am having trouble connecting right now, but please review the Education tab for comprehensive guides on your crops and diseases!",
          isUser: false,
        ),
      );
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  void clearConversation() {
    _messages.clear();
    _messages.add(
      ChatMessageModel(
        text: "Conversation cleared. How can I assist you with your farming today?",
        isUser: false,
      ),
    );
    notifyListeners();
  }
}

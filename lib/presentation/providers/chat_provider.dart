import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/// Main ChatProvider this is used to manage the messages information of the app
class ChatProvider extends ChangeNotifier {
  final getYesNoAnswer = GetYesNoAnswer();
  final chatScrollController = ScrollController();

  List<Message> messages = [
    Message(text: 'Hi!', fromWho: FromWho.me),
  ];

  /// Add a message in the messages list for me chat
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);

    notifyListeners();
    moveScrollToBottom();

    if (text.endsWith('?')) {
      await otherReply();
    }
  }

  /// Add a message in the messages list for other chat
  Future<void> otherReply() async {
    final otherMessage = await getYesNoAnswer.getAnswer();
    messages.add(otherMessage);

    notifyListeners();
    moveScrollToBottom();
  }

  /// Used to move the scroll to bottom
  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear);
  }
}

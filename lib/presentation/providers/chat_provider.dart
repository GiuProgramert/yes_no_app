import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final getYesNoAnswer = GetYesNoAnswer();
  final chatScrollController = ScrollController();

  List<Message> messages = [
    Message(text: 'Hola Giu!', fromWho: FromWho.me),
    Message(text: 'Que capo que sos!', fromWho: FromWho.me),
  ];

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

  Future<void> otherReply() async {
    final otherMessage = await getYesNoAnswer.getAnswer();
    messages.add(otherMessage);

    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear);
  }
}

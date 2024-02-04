import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/other_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

/// Main Chat screen of the app
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/128/3562/3562833.png"),
          ),
        ),
        title: const Text('Yes No Bot'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

/// Body of the ChatScreen
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Global ChatProvider used to get the global context of the messages
    final chatProvider = context.watch<ChatProvider>();

    /// ListView builder to add the bubbles of the chat
    final listViewBuilder = ListView.builder(
      controller: chatProvider.chatScrollController,
      itemCount: chatProvider.messages.length,
      itemBuilder: (context, index) {
        final message = chatProvider.messages[index];

        return message.fromWho == FromWho.me
            ? MyMessageBubble(message: message)
            : OtherMessageBubble(message: message);
      },
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: listViewBuilder),
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/// Used to reference the bubble chat of the bot
class OtherMessageBubble extends StatelessWidget {
  final Message message;

  const OtherMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    /// Colors have themes information of the current color
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _ImageBubble(
          message.imageUrl!,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

/// Bubble used for a Image in this case only the bot sents images so
/// is used only for it
class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text('Giu is sending an image'));
        },
      ),
    );
  }
}

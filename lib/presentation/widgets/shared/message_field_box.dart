import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Colors.transparent));

    final inputDecoration = InputDecoration(
        hintText: 'End your message with a "?"',
        filled: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        suffixIcon: IconButton(
            onPressed: () {
              final textValue = textController.value.text;
              textController.clear();
              onValue(textValue);
            },
            icon: const Icon(Icons.send_outlined)));

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      decoration: inputDecoration,
      controller: textController,
      onFieldSubmitted: (value) {
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    required this.onSend,
    super.key,
  });
  final void Function(String) onSend;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isComposing = false;
  bool _showingEmojis = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            _showingEmojis
                                ? Icons.close
                                : Icons.insert_emoticon,
                          ),
                          onPressed: () {
                            _showingEmojis = !_showingEmojis;
                            setState(() {});
                            // Implement emoji picker or open keyboard
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            maxLines: null,
                            onChanged: (String text) {
                              setState(() {
                                _isComposing = text.isNotEmpty;
                              });
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Type a message',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            // Implement file picker or open camera/gallery
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _isComposing
                              ? () {
                                  widget.onSend(_textEditingController.text);
                                  _textEditingController.clear();
                                  setState(() {
                                    _isComposing = false;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showingEmojis)
              SizedBox(
                height: 300,
                width: double.infinity,
                child: EmojiPicker(
                  onEmojiSelected: (emoji, category) {
                    setState(() {
                      _textEditingController.text =
                          _textEditingController.text + category.emoji;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

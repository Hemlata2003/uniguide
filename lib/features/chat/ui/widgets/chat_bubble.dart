import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  Future<void> _copyText(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: message.text));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.isUser ? 'Message copied' : 'Answer copied'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;

    final bubbleColor = isUser ? const Color(0xFF1B4D8C) : Colors.white;
    final textColor = isUser ? Colors.white : const Color(0xFF1B2430);
    final borderColor =
        isUser ? Colors.transparent : const Color(0xFFD9E1EC);

    final timestamp = TimeOfDay.fromDateTime(message.timestamp).format(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width > 700 ? 620 : 420,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24),
              bottomLeft: Radius.circular(isUser ? 24 : 8),
              bottomRight: Radius.circular(isUser ? 8 : 24),
            ),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 10),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isUser)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F0FB),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      message.source ?? 'UniGuide',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF1B4D8C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                SelectableText(
                  message.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      timestamp,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isUser
                            ? Colors.white.withValues(alpha: 0.72)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () => _copyText(context),
                      borderRadius: BorderRadius.circular(999),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.content_copy_rounded,
                          size: 16,
                          color: isUser
                              ? Colors.white.withValues(alpha: 0.88)
                              : const Color(0xFF5E6B7D),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

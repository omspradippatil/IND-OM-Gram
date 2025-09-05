import 'package:flutter/material.dart';
import 'package:indomgram/models/message_model.dart';
import 'package:indomgram/models/user_model.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final User currentUser;
  final bool showTimestamp;
  
  const ChatBubble({
    super.key,
    required this.message,
    required this.currentUser,
    this.showTimestamp = false,
  });

  bool get isMe => message.sender.id == currentUser.id;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(message.sender.profileImageUrl),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: isMe 
                      ? colorScheme.primary.withOpacity(0.2) 
                      : colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(20).copyWith(
                    bottomRight: isMe ? const Radius.circular(0) : null,
                    bottomLeft: isMe ? null : const Radius.circular(0),
                  ),
                ),
                child: _buildMessageContent(),
              ),
              if (isMe) ...[
                const SizedBox(width: 8),
                isMe && message.isRead
                    ? Icon(
                        Icons.done_all,
                        size: 16,
                        color: colorScheme.primary,
                      )
                    : const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.grey,
                      ),
              ],
            ],
          ),
          if (showTimestamp)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _formatTime(message.timestamp),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return Text(message.content);
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                message.content,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      case MessageType.video:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    message.content, // thumbnail URL in real app
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        );
      case MessageType.audio:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text('Audio message'),
            ),
          ],
        );
      default:
        return Text(message.content);
    }
  }
  
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

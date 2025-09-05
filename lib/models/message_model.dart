import 'user_model.dart';

class Message {
  final String id;
  final User sender;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;
  
  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.type = MessageType.text,
  });
}

enum MessageType { text, image, video, audio }

class Conversation {
  final String id;
  final User user;
  final List<Message> messages;
  final DateTime lastMessageTime;
  final bool unread;
  
  Conversation({
    required this.id,
    required this.user,
    required this.messages,
    required this.lastMessageTime,
    this.unread = false,
  });
  
  String get lastMessage {
    if (messages.isEmpty) return '';
    
    final last = messages.last;
    switch (last.type) {
      case MessageType.text:
        return last.content;
      case MessageType.image:
        return '📷 Image';
      case MessageType.video:
        return '🎥 Video';
      case MessageType.audio:
        return '🎵 Audio';
      default:
        return '';
    }
  }
}

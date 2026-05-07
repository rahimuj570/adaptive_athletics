class ChatModel {
  final String type;
  final String message;
  final int? conversationId;
  final DateTime? timestamp;

  ChatModel({
    required this.type,
    required this.message,
    this.conversationId,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "message": message,
      if (conversationId != null) "conversation_id": conversationId,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      conversationId: json['conversation_id'],
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
    );
  }
}

enum ChatType { chatMessage, userMessage, aiMessage, connectionEstablished }

String chatTypeToString(ChatType type) {
  switch (type) {
    case ChatType.chatMessage:
      return 'chat_message';

    case ChatType.userMessage:
      return 'user_message';

    case ChatType.aiMessage:
      return 'ai_message';

    case ChatType.connectionEstablished:
      return 'connection_established';
  }
}

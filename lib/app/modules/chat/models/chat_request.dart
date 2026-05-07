// {
//     "type": "chat_message",
//     "message": "What is my training plan for tomorrow?",
//     "conversation_id": 123 // Optional: omit to start a new conversation
// }
// {
//     "type": "connection_established",
//     "message": "Connected to chatbot",
//     "conversation_id": null
// }
class ChatRequest {
  final String type; // chat_message, connection_established, etc.
  final String message; // The message content
  final int? conversationId;

  ChatRequest({
    required this.type,
    required this.message,
    required this.conversationId,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'message': message,
    'conversation_id': conversationId,
  };

  factory ChatRequest.fromJson(Map<String, dynamic> json) => ChatRequest(
    type: json['type'],
    message: json['message'],
    conversationId: json['conversation_id'],
  );
}

enum ChatRequestType { chatMessage, connectionEstablished }

String chatrequestTypeToString(ChatRequestType type) {
  switch (type) {
    case ChatRequestType.chatMessage:
      return 'chat_message';
    case ChatRequestType.connectionEstablished:
      return 'connection_established';
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/chat_model.dart';

class ChatController extends GetxController {
  WebSocketChannel? _channel;

  final RxList<ChatModel> messages = <ChatModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final RxBool isConnected = false.obs;

  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  int? conversationId;

  @override
  void onInit() {
    super.onInit();

    connectSocket();
  }

  @override
  void onClose() {
    disconnectSocket();

    messageController.dispose();

    scrollController.dispose();

    super.onClose();
  }

  // =========================
  // CONNECT SOCKET
  // =========================

  void connectSocket() async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
          "ws://10.10.13.24:8002/ws/chat/?token=${await AuthPrefsService().getToken()}",
        ),
      );

      isConnected.value = true;

      _channel?.stream.listen(
        (event) {
          debugPrint('SOCKET EVENT => $event');

          final data = jsonDecode(event);

          final type = data['type'];

          // AI Typing Status
          if (type == 'ai_typing') {
            isSending.value = data['is_typing'] ?? false;
            return;
          }

          // Ignore connection event
          if (type == 'connection_established') {
            return;
          }

          // Chat message
          if (type == 'user_message' || type == 'ai_message') {
            final message = ChatModel.fromJson(data);

            messages.add(message);

            scrollToBottom();

            // AI finished response
            if (type == 'ai_message') {
              isSending.value = false;
            }
          }
        },

        onError: (e) {
          debugPrint('Socket Error => $e');
          isSending.value = false;
        },

        onDone: () {
          debugPrint('Socket Closed');
          isSending.value = false;
        },
      );
    } catch (e) {
      isConnected.value = false;

      debugPrint("Socket Connect Error => $e");
    }
  }

  // =========================
  // DISCONNECT
  // =========================

  void disconnectSocket() {
    _channel?.sink.close();
  }

  // =========================
  // SEND MESSAGE
  // =========================

  void sendAiMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    final payload = {
      "type": "chat_message",
      "message": text,
      "conversation_id": conversationId,
    };

    _channel?.sink.add(jsonEncode(payload));

    messageController.clear();
  }

  // =========================
  // SCROLL
  // =========================

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,

          duration: const Duration(milliseconds: 300),

          curve: Curves.easeOut,
        );
      }
    });
  }
}

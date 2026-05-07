import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/background.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),

        child: Background(
          image: ImageAssets.chat,

          child: Stack(
            children: [
              // =========================
              // BODY
              // =========================
              Column(
                children: [
                  SafeArea(bottom: false, child: SizedBox(height: 56.h)),

                  // =========================
                  // CHAT LIST
                  // =========================
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value &&
                          controller.messages.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white54,
                          ),
                        );
                      }

                      if (controller.messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 80.sp,
                                color: Colors.white24,
                              ),

                              SizedBox(height: 16.h),

                              Text(
                                'Start a conversation',

                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white54,
                                ),
                              ),

                              SizedBox(height: 8.h),

                              Text(
                                'Ask your AI assistant anything',

                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white38,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: controller.scrollController,

                        padding: EdgeInsets.all(16.r),

                        itemCount: controller.messages.length + 1,

                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _DateSeparator(
                              date:
                                  controller.messages.first.timestamp ??
                                  DateTime.now(),
                            );
                          }

                          final message = controller.messages[index - 1];

                          return MessageBubble(message: message);
                        },
                      );
                    }),
                  ),

                  // =========================
                  // TYPING
                  // =========================
                  Obx(() {
                    if (!controller.isSending.value) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.r,

                            backgroundColor: const Color(0xFF2A2A4A),

                            child: Icon(
                              Icons.smart_toy,
                              color: Colors.white70,
                              size: 18.sp,
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A4A),

                              borderRadius: BorderRadius.circular(20.r),
                            ),

                            child: const _TypingIndicator(),
                          ),
                        ],
                      ),
                    );
                  }),

                  // =========================
                  // INPUT
                  // =========================
                  Container(
                    padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),

                    decoration: BoxDecoration(
                      color: Colors.transparent,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(77),

                          blurRadius: 10,

                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),

                    child: SafeArea(
                      top: false,

                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.messageController,

                              style: const TextStyle(color: Colors.white),

                              decoration: InputDecoration(
                                hintText: 'Type a message...',

                                hintStyle: const TextStyle(
                                  color: Colors.white38,
                                ),

                                filled: true,

                                fillColor: const Color(0xFF212121),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),

                                  borderSide: BorderSide.none,
                                ),

                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                              ),

                              maxLines: null,

                              textInputAction: TextInputAction.send,

                              onSubmitted: (_) {
                                controller.sendAiMessage();
                              },
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Obx(() {
                            final isSending = controller.isSending.value;

                            return GestureDetector(
                              onTap: isSending
                                  ? null
                                  : controller.sendAiMessage,

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),

                                width: 46.r,
                                height: 46.r,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  gradient: isSending
                                      ? LinearGradient(
                                          begin: const Alignment(0.50, 0.00),

                                          end: const Alignment(0.50, 1.00),

                                          colors: [
                                            Colors.grey.shade600,
                                            Colors.grey.shade800,
                                          ],
                                        )
                                      : const LinearGradient(
                                          begin: Alignment(0.50, 0.00),

                                          end: Alignment(0.50, 1.00),

                                          colors: [
                                            Color(0xFF3C8BBF),
                                            Color(0xFF8AC7F7),
                                          ],
                                        ),
                                ),

                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 24.r,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // =========================
              // HEADER
              // =========================
              Positioned(
                top: MediaQuery.of(context).padding.top + 8.h,

                left: 16.w,

                width: 1.sw - 16.w,

                child: Row(
                  children: [
                    _backButton(context),

                    SizedBox(width: 48.w),

                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.ai,

                          width: 34.w,
                          height: 34.h,
                        ),

                        SizedBox(width: 12.w),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Adaptiv AI',

                              style: TextStyle(
                                color: Color(0xFFF5F5F5),

                                fontSize: 18,

                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Obx(
                              () => Text(
                                controller.isConnected.value
                                    ? 'Online'
                                    : 'Connecting...',

                                style: const TextStyle(
                                  color: Color(0xFFA1A1A1),

                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),

      child: Container(
        padding: EdgeInsets.all(8.r),

        decoration: BoxDecoration(
          color: Colors.black45,

          borderRadius: BorderRadius.circular(10.r),
        ),

        child: Icon(Icons.chevron_left, color: Colors.white, size: 24.sp),
      ),
    );
  }
}

// =========================
// DATE SEPARATOR
// =========================

class _DateSeparator extends StatelessWidget {
  final DateTime date;

  const _DateSeparator({required this.date});

  String _label() {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return 'Today';

    if (d == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }

    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),

      child: Center(
        child: Text(
          _label(),

          style: TextStyle(
            color: Colors.white54,

            fontSize: 13.sp,

            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// =========================
// TYPING INDICATOR
// =========================

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      3,

      (i) => AnimationController(
        vsync: this,

        duration: const Duration(milliseconds: 400),
      )..repeat(reverse: true, period: Duration(milliseconds: 900 + i * 150)),
    );

    _animations = _controllers
        .map((c) => Tween<double>(begin: 0.3, end: 1.0).animate(c))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: List.generate(3, (i) {
        return Padding(
          padding: EdgeInsets.only(right: i < 2 ? 4.w : 0),

          child: FadeTransition(
            opacity: _animations[i],

            child: Container(
              width: 8.r,
              height: 8.r,

              decoration: const BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// =========================
// MESSAGE BUBBLE
// =========================

class MessageBubble extends StatelessWidget {
  final ChatModel message;

  const MessageBubble({super.key, required this.message});

  bool get isUser {
    return message.type == chatTypeToString(ChatType.userMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),

      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,

        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16.r,

              backgroundColor: Colors.transparent,

              child: SvgPicture.asset(
                ImageAssets.ai,

                width: 28.w,
                height: 28.h,
              ),
            ),

            SizedBox(width: 8.w),
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.70.sw),

              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),

              decoration: BoxDecoration(
                color: isUser
                    ? AppColor.whiteColor.withAlpha(54)
                    : const Color(0xFF2A2A4A),

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),

                  topRight: Radius.circular(12.r),

                  bottomLeft: Radius.circular(isUser ? 12.r : 4.r),

                  bottomRight: Radius.circular(isUser ? 4.r : 12.r),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    message.message,

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 15.sp,

                      height: 1.4,
                    ),
                  ),

                  if (message.timestamp != null)
                    Align(
                      alignment: Alignment.bottomRight,

                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),

                        child: Text(
                          DateFormat('hh:mm a').format(message.timestamp!),

                          style: TextStyle(
                            color: Colors.white38,

                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

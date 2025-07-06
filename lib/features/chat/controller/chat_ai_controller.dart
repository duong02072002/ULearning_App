import 'package:flutter_ulearning_app/common/models/chat_ai_entities.dart';
import 'package:flutter_ulearning_app/features/chat/repo/chat_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_ai_controller.g.dart';

@riverpod
class ChatAIController extends _$ChatAIController {
  String chatSession = 'default';

  /// Danh sách các phiên trò chuyện (session)
  final List<AIChatSessionEntity> sessionsList = [];

  @override
  List<AIChatMessage> build() {
    _startNewSessionOnInit(); // mỗi lần build là khởi tạo session mới
    return [];
  }

  /// Khởi tạo session mới ngay khi mở chat
  Future<void> _startNewSessionOnInit() async {
    final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    chatSession = newSessionId;
    await loadHistory(session: newSessionId);
    await loadSessionList();
  }

  /// Gửi tin nhắn cho AI
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // thêm tin nhắn người dùng
    state = [...state, AIChatMessage(role: "user", content: message)];

    // thêm tạm tin nhắn AI đang trả lời
    state = [...state, AIChatMessage(role: "ai", content: "...")];

    try {
      final response = await ChatAIRepo.sendMessageToAI(
        message,
        session: chatSession,
      );

      if (response.code != 200) throw Exception(response.msg);

      // nếu backend trả về session mới thì cập nhật
      if (response.chatSession != null && response.chatSession != chatSession) {
        chatSession = response.chatSession!;
        await loadHistory(session: chatSession);
      } else {
        // thay thế "..." bằng phản hồi thật
        state = [
          ...state.sublist(0, state.length - 1),
          AIChatMessage(role: "ai", content: response.data),
        ];
      }

      await loadSessionList();
    } catch (e) {
      state = [
        ...state.sublist(0, state.length - 1),
        AIChatMessage(role: "ai", content: "❌ Lỗi: ${e.toString()}"),
      ];
    }
  }

  /// Tải lịch sử trò chuyện từ backend
  Future<void> loadHistory({String session = 'default'}) async {
    chatSession = session;

    try {
      final history = await ChatAIRepo.fetchChatHistory(session: session);
      state = history;
    } catch (e) {
      state = [
        AIChatMessage(
          role: "ai",
          content: "❌ Lỗi tải lịch sử: ${e.toString()}",
        ),
      ];
    }
  }

  /// Tải danh sách các phiên trò chuyện
  Future<void> loadSessionList() async {
    try {
      final list = await ChatAIRepo.fetchChatSessions();
      sessionsList
        ..clear()
        ..addAll(list);
    } catch (e) {
      // không làm gì nếu lỗi
    }
  }

  /// Người dùng nhấn nút New Chat
  Future<void> startNewSession() async {
    final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    chatSession = newSessionId;
    state = []; // xóa toàn bộ tin nhắn cũ
    await loadHistory(session: newSessionId);
    await loadSessionList();
  }

  /// Chuyển sang phiên trò chuyện khác
  Future<void> switchSession(String sessionId) async {
    if (sessionId != chatSession) {
      await loadHistory(session: sessionId);
    }
  }
}

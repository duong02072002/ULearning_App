import 'package:flutter_ulearning_app/common/models/chat_ai_entities.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';

class ChatAIRepo {
  /// Gửi tin nhắn đến AI
  static Future<AIChatResponseEntity> sendMessageToAI(
    String message, {
    String session = 'default',
  }) async {
    final request = AIChatRequestEntity(message: message, chatSession: session);
    final res = await HttpUtil().post('api/chatWithAI', data: request.toJson());
    return AIChatResponseEntity.fromJson(res);
  }

  /// Lấy lịch sử tin nhắn theo session
  static Future<List<AIChatMessage>> fetchChatHistory({
    String session = 'default',
  }) async {
    final res = await HttpUtil().get(
      'api/chatWithAI/history',
      queryParameters: {"chat_session": session},
    );

    final history = AIChatHistoryResponseEntity.fromJson(res);

    if (history.code != 200) {
      throw Exception(history.msg ?? 'Failed to fetch chat history');
    }

    return history.data ?? [];
  }

  /// Lấy danh sách các phiên trò chuyện
  static Future<List<AIChatSessionEntity>> fetchChatSessions() async {
    final res = await HttpUtil().get('api/chatWithAI/sessions');

    if ((res['code'] ?? 500) != 200) {
      throw Exception(res['msg'] ?? 'Failed to fetch sessions');
    }

    final data = res['data'] as List<dynamic>?;

    if (data == null) {
      return [];
    }

    return data.map((e) => AIChatSessionEntity.fromJson(e)).toList();
  }
}

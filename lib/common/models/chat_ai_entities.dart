class AIChatRequestEntity {
  final String message;
  final String chatSession;

  AIChatRequestEntity({required this.message, this.chatSession = 'default'});

  Map<String, dynamic> toJson() => {
    "message": message,
    "chat_session": chatSession,
  };
}

class AIChatMessage {
  final String role;
  final String content;

  AIChatMessage({required this.role, required this.content});

  factory AIChatMessage.fromJson(Map<String, dynamic> json) {
    return AIChatMessage(
      role: json['role'] ?? '',
      content: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'role': role, 'message': content};
}

class AIChatResponseEntity {
  final int code;
  final String msg;
  final String data;
  final String? chatSession;

  AIChatResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
    this.chatSession,
  });

  factory AIChatResponseEntity.fromJson(Map<String, dynamic> json) {
    return AIChatResponseEntity(
      code: json["code"] ?? 500,
      msg: json["msg"] ?? 'Unknown',
      data: json["data"]?["reply"]?.toString() ?? '',
      chatSession: json["data"]?["chat_session"],
    );
  }
}

class AIChatHistoryResponseEntity {
  final int code;
  final String msg;
  final List<AIChatMessage> data;

  AIChatHistoryResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory AIChatHistoryResponseEntity.fromJson(Map<String, dynamic> json) {
    return AIChatHistoryResponseEntity(
      code: json['code'] ?? 500,
      msg: json['msg'] ?? 'Unknown error',
      data:
          (json['data'] as List<dynamic>? ?? [])
              .map((e) => AIChatMessage.fromJson(e))
              .toList(),
    );
  }
}

class AIChatSessionEntity {
  final String session;
  final String preview;
  final String? createdAt;

  AIChatSessionEntity({
    required this.session,
    required this.preview,
    this.createdAt,
  });

  factory AIChatSessionEntity.fromJson(Map<String, dynamic> json) {
    return AIChatSessionEntity(
      session: json['session'] ?? '',
      preview: json['preview'] ?? '',
      createdAt: json['created_at'],
    );
  }
}

class ReviewRequestEntity {
  int? rating;
  String? comment;
  ReviewRequestEntity({this.rating, this.comment});
  Map<String, dynamic> toJson() => {"rating": rating, "comment": comment};
}

class UserItem {
  final int id;
  final String name;
  final String? avatar;
  final String? token; // Thêm dòng này
  UserItem({required this.id, required this.name, this.avatar, this.token});
  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    token: json["token"], // Thêm dòng này
  );
}

class ReviewItem {
  final int id;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final UserItem user;
  ReviewItem({
    required this.id,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.user,
  });
  factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    user: UserItem.fromJson(json["user"]),
  );
}

class ReviewListResponseEntity {
  final int code;
  final String msg;
  final List<ReviewItem> data;
  ReviewListResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });
  factory ReviewListResponseEntity.fromJson(Map<String, dynamic> json) =>
      ReviewListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data:
            (json["data"] as List).map((e) => ReviewItem.fromJson(e)).toList(),
      );
}

class ReviewPostResponseEntity {
  final int code;
  final String msg;
  final int ratingCount;
  final double score;
  ReviewPostResponseEntity({
    required this.code,
    required this.msg,
    required this.ratingCount,
    required this.score,
  });
  factory ReviewPostResponseEntity.fromJson(Map<String, dynamic> json) =>
      ReviewPostResponseEntity(
        code: json["code"],
        msg: json["msg"],
        ratingCount: json["data"]["rating_count"],
        score: (json["data"]["score"] as num).toDouble(),
      );
}

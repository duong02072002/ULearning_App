class CourseRequestEntity {
  int? id;

  CourseRequestEntity({this.id});

  Map<String, dynamic> toJson() => {"id": id};
}

class SearchRequestEntity {
  String? search;

  SearchRequestEntity({this.search});

  Map<String, dynamic> toJson() => {"search": search};
}

class CourseSearchResponse {
  final int code;
  final String msg;
  final Pagination data;

  CourseSearchResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CourseSearchResponse.fromJson(Map<String, dynamic> json) {
    return CourseSearchResponse(
      code: json['code'],
      msg: json['msg'],
      data: Pagination.fromJson(json['data']),
    );
  }
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<CourseItem> items;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      items: (json['data'] as List).map((e) => CourseItem.fromJson(e)).toList(),
    );
  }
}

class CourseListResponseEntity {
  int? code;
  String? msg;
  List<CourseItem>? data;

  CourseListResponseEntity({this.code, this.msg, this.data});

  factory CourseListResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data:
            json["data"] == null
                ? []
                : List<CourseItem>.from(
                  json["data"].map((x) => CourseItem.fromJson(x)),
                ),
      );
}

//api post response msg
class CourseDetailResponseEntity {
  int? code;
  String? msg;
  CourseItem? data;

  CourseDetailResponseEntity({this.code, this.msg, this.data});

  factory CourseDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: CourseItem.fromJson(json["data"]),
      );
}

class AuthorRequestEntity {
  String? token;

  AuthorRequestEntity({this.token});

  Map<String, dynamic> toJson() => {"token": token};
}

//api post response msg
class AuthorResponseEntity {
  int? code;
  String? msg;
  AuthorItem? data;

  AuthorResponseEntity({this.code, this.msg, this.data});

  factory AuthorResponseEntity.fromJson(Map<String, dynamic> json) =>
      AuthorResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: AuthorItem.fromJson(json["data"]),
      );
}

// login result
class AuthorItem {
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? job;
  int? follow;
  double? score;
  int? download;
  int? online;

  AuthorItem({
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.job,
    this.follow,
    this.score,
    this.download,
    this.online,
  });

  factory AuthorItem.fromJson(Map<String, dynamic> json) => AuthorItem(
    token: json["token"],
    name: json["name"],
    description: json["description"],
    avatar: json["avatar"],
    job: json["job"],
    follow: json["follow"],
    score: (json["score"] as num?)?.toDouble(),
    download: json["download"],
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "description": description,
    "avatar": avatar,
    "job": job,
    "follow": follow,
    "score": score,
    "download": download,
    "online": online,
  };
}

// login result
class CourseItem {
  String? user_token;
  String? name;
  String? description;
  String? thumbnail;
  String? video;
  String? price;
  String? amount_total;
  int? lesson_num;
  int? video_len;
  int? down_num;
  int? follow;
  int? id;
  double? score;
  int? ratingCount;

  CourseItem({
    this.user_token,
    this.name,
    this.description,
    this.thumbnail,
    this.video,
    this.price,
    this.amount_total,
    this.lesson_num,
    this.video_len,
    this.down_num,
    this.follow,
    this.id,
    this.score,
    this.ratingCount,
  });

  factory CourseItem.fromJson(Map<String, dynamic> json) => CourseItem(
    user_token: json["user_token"],
    name: json["name"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    video: json["video"],
    price: json["price"].toString(),
    amount_total: json["amount_total"],
    lesson_num: json["lesson_num"],
    video_len: json["video_length"],
    down_num: json["down_num"],
    follow: json["follow"],
    id: json["id"],
    score: (json["score"] as num?)?.toDouble(),
    ratingCount: json["rating_count"], // ← map JSON
  );

  Map<String, dynamic> toJson() => {
    "user_token": user_token,
    "name": name,
    "description": description,
    "thumbnail": thumbnail,
    "video": video,
    "price": price,
    "amount_total": amount_total,
    "lesson_num": lesson_num,
    "video_len": video_len,
    "down_num": down_num,
    "follow": follow,
    "id": id,
    "score": score,
    "rating_count": ratingCount,
  };
}

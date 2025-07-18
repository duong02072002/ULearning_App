class SearchFilter {
  final String? search;
  final List<int>? categories;
  final double? minPrice, maxPrice;
  final double? minScore, maxScore;
  final int? minLessons, maxLessons;
  final int perPage, page;

  SearchFilter({
    this.search,
    this.categories,
    this.minPrice,
    this.maxPrice,
    this.minScore,
    this.maxScore,
    this.minLessons,
    this.maxLessons,
    this.perPage = 12,
    this.page = 1,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> d = {};
    if (search != null) d['search'] = search;
    if (categories != null && categories!.isNotEmpty)
      d['categories[]'] = categories;
    if (minPrice != null) d['min_price'] = minPrice;
    if (maxPrice != null) d['max_price'] = maxPrice;
    if (minScore != null) d['min_score'] = minScore;
    if (maxScore != null) d['max_score'] = maxScore;
    if (minLessons != null) d['min_lessons'] = minLessons;
    if (maxLessons != null) d['max_lessons'] = maxLessons;
    d['per_page'] = perPage;
    d['page'] = page;
    return d;
  }

  /// ✅ Thêm hàm này:
  SearchFilter copyWith({
    String? search,
    List<int>? categories,
    double? minPrice,
    double? maxPrice,
    double? minScore,
    double? maxScore,
    int? minLessons,
    int? maxLessons,
    int? perPage,
    int? page,
  }) {
    return SearchFilter(
      search: search ?? this.search,
      categories: categories ?? this.categories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minScore: minScore ?? this.minScore,
      maxScore: maxScore ?? this.maxScore,
      minLessons: minLessons ?? this.minLessons,
      maxLessons: maxLessons ?? this.maxLessons,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }
}

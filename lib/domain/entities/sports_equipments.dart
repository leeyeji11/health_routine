enum Category {
  cardio, // 유산소
  strength, // 근력
  flexibility, // 유연성
  balance, // 균형 운동
  etc, // 기타
}

/// **`Category`를 한국어로 변환하는 함수 추가**
extension CategoryExtension on Category {
  String get displayName {
    switch (this) {
      case Category.cardio:
        return "유산소";
      case Category.strength:
        return "근력";
      case Category.flexibility:
        return "유연성";
      case Category.balance:
        return "균형 운동";
      case Category.etc:
        return "기타";
    }
  }
}

class SportsEquipments {
  BigInt key; // 운동기구PK
  String? url; // 사진 URL
  String? name; // 기구명
  String? description; // 기구설명
  List<Category>? categories; // 카테고리
  Map<String, dynamic>? manual; // 메뉴얼 URL
  String? videoUrl; // 영상 자료 URL
  BigInt? bookmarkId; // 북마크PLK
  BigInt? routineId; // 루틴 PK

  SportsEquipments({
    required this.key,
    this.url,
    this.name,
    this.description,
    this.categories,
    this.manual,
    this.videoUrl,
    this.bookmarkId,
    this.routineId,
  });

  /// **Firestore 저장용 (객체 → JSON)**
  Map<String, dynamic> toJson() {
    return {
      'key': key.toString(),
      'url': url,
      'name': name,
      'description': description,
      'categories':
          categories?.map((e) => e.name).toList(), // `enum`을 `String` 리스트로 변환
      'manual': manual, // Map 형태로 저장
      'videoUrl': videoUrl,
      'bookmarkId': bookmarkId?.toString(),
      'routineId': routineId?.toString(),
    };
  }

  /// **Firestore 불러올 때 (JSON → 객체)**
  factory SportsEquipments.fromJson(Map<String, dynamic> json) {
    return SportsEquipments(
      key: BigInt.parse(json['key']),
      url: json['url'],
      name: json['name'],
      description: json['description'],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.values.firstWhere((c) => c.name == e))
          .toList(), // `String`을 `enum` 리스트로 변환
      manual: json['manual'], // 그대로 Map으로 변환
      videoUrl: json['videoUrl'],
      bookmarkId:
          json['bookmarkId'] != null ? BigInt.parse(json['bookmarkId']) : null,
      routineId:
          json['routineId'] != null ? BigInt.parse(json['routineId']) : null,
    );
  }
}

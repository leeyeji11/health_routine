enum Difficulty {
  easy, // 초급
  medium, // 중급
  hard, // 상급
  stretching, // 스트레칭
}

enum Category {
  cardio, // 유산소
  strength, // 근력
  flexibility, // 유연성
  balance, // 균형 운동
  etc, // 기타
}

class Routine {
  final BigInt routineId; // 루틴PK
  String title; // 루틴명
  String description; // 루틴 설명
  int? time; // 운동 시간 (분 단위)
  Category category; // 운동 카테고리 (예: 유산소, 근력)
  String? image; // 루틴 이미지 URL
  final Difficulty difficulty; // 난이도 (탭별 구분) ⭐️
  final DateTime startDate; // 루틴 시작 날짜
  final DateTime? endDate; // 루틴 종료 날짜 (선택 사항)
  final DateTime? createAt; // 루틴 생성 날짜
  DateTime? updateAt; // 루틴 마지막 수정 날짜
  final BigInt bookmarkId; // 북마크PK

  Routine(
      {required this.routineId,
      required this.title,
      required this.description,
      this.time,
      required this.category,
      this.image,
      required this.difficulty,
      required this.startDate,
      this.endDate,
      DateTime? createAt,
      this.updateAt,
      required this.bookmarkId})
      : createAt = createAt ?? DateTime.now(); // 기본값 설정

  /// ✅ **팩토리 생성자 (JSON → Routine 객체 변환)**
  factory Routine.fromMap(Map<String, dynamic> map) {
    try {
      return Routine(
        routineId: BigInt.parse(map["routineId"]),
        title: map["title"],
        description: map["description"],
        time: map["time"],
        category: Category.values.firstWhere(
          (e) => e.toString().split('.').last == map["category"],
          orElse: () => Category.etc, // ✅ 잘못된 값이면 기본값
        ),
        difficulty: Difficulty.values.firstWhere(
          (e) => e.toString().split('.').last == map["difficulty"],
        ),
        startDate: DateTime.parse(map["startDate"]),
        endDate: map["endDate"] != null ? DateTime.parse(map["endDate"]) : null,
        createAt:
            map["createAt"] != null ? DateTime.parse(map["createAt"]) : null,
        updateAt:
            map["updateAt"] != null ? DateTime.parse(map["updateAt"]) : null,
        bookmarkId: BigInt.parse(map["bookmarkId"]),
      );
    } catch (e) {
      throw FormatException("Invalid Routine JSON format: $e");
    }
  }

  /// ✅ **객체를 JSON(Map)으로 변환**
  Map<String, dynamic> toMap() {
    return {
      "routineId": routineId.toString(), // BigInt → String 변환 (JSON 호환)
      "title": title,
      "description": description,
      "time": time,
      "category": category.toString().split('.').last,
      "image": image,
      "difficulty": difficulty.toString().split('.').last, // Enum → String 변환
      "startDate": startDate.toIso8601String(), // 날짜 → String 변환
      "endDate": endDate?.toIso8601String(),
      "createAt": createAt?.toIso8601String(),
      "updateAt": updateAt?.toIso8601String(),
      "bookmarkId": bookmarkId.toString(), // BigInt → String 변환
    };
  }
}

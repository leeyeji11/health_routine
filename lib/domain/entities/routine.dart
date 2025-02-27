enum Difficulty {
  easy, // 초급
  medium, // 중급
  hard, // 상급
  stretching, // 스트레칭
}

class Routine {
  final BigInt routineId; // 루틴PK
  String title; // 루틴명
  String description; // 루틴 설명
  int? time; // 운동 시간 (분 단위)
  String category; // 운동 카테고리 (예: 유산소, 근력)
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
      this.createAt,
      this.updateAt,
      required this.bookmarkId});

  Map<String, dynamic> toMap() {
    return {
      "routineId": routineId.toString(), // BigInt → String 변환 (JSON 호환)
      "title": title,
      "description": description,
      "time": time,
      "category": category,
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

enum Type {
  // 타입
  routine, // 운동 루틴
  eauipment // 운동 기구
}

class Bookmark {
  final BigInt bookmarkId; // 북마크PK
  DateTime? createAt; // 생성일
  final BigInt userKey; // 회원PK (FK?)

  Bookmark({
    required this.bookmarkId,
    DateTime? createAt,
    required this.userKey,
  }) : createAt = createAt ?? DateTime.now(); // 기본값 설정
}

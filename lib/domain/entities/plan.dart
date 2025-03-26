class Plan {
  BigInt planId; // 계획PK
  DateTime date; // 날짜
  int? order; // 순서
  DateTime? createAt; // 생성일
  BigInt userKey; // 회원PK (FK)
  BigInt routineId; // 루틴PK (FK)

  Plan(
      {required this.planId,
      required this.date,
      this.order,
      DateTime? createAt, // 값을 안 넣으면 자동으로 현재 시간
      required this.userKey,
      required this.routineId})
      : createAt = createAt ?? DateTime.now(); // 기본값 설정
}

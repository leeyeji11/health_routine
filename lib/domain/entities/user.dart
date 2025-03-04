class User {
  final BigInt userKey; // 회원PK (UUID)
  String userID; // 회원 ID
  String email; // 이메일
  String phone; // 핸드폰
  String password; // 비밀번호
  String? name; // 이름
  double? level; // 레벨
  final DateTime? createAt; // 생성일
  DateTime? updateAt; // 수정일
  double? goal; // 하루목표

  User(
      {required this.userKey,
      required this.userID,
      required this.email,
      required this.phone,
      required this.password,
      this.name,
      this.level,
      DateTime? createAt, // 값을 안 넣으면 자동으로 현재 시간
      this.updateAt,
      this.goal})
      : createAt = createAt ?? DateTime.now(); // 기본값 설정
}

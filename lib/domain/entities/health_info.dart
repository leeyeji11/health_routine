class HealthInfo {
  final BigInt infoId; // 신체정보PK
  final BigInt userKey; // 회원PK (FK?)
  double? height; // 키
  double? weight; // 몸무게
  double? bmi; // BMI
  int age; // 나이
  bool gender; // 성별
  final DateTime? createAt; // 생성일
  DateTime? updateAt; // 수정일

  HealthInfo(
      {required this.infoId,
      required this.userKey,
      this.height,
      this.weight,
      this.bmi,
      required this.age,
      required this.gender,
      DateTime? createAt,
      this.updateAt})
      : createAt = createAt ?? DateTime.now(); // 기본값 설정
}

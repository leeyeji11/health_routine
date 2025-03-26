class ExerciseTime {
  final BigInt timeId; // 운동시간PK
  DateTime start; // 시작시간
  DateTime end; // 종료시간
  double? rate; // 달성률
  final BigInt userKey; // 회원PK

  ExerciseTime(
      {required this.timeId,
      required this.start,
      required this.end,
      required this.rate,
      required this.userKey});
}

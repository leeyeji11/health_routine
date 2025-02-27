class SportsEquipment {
  BigInt key; // 운동기구PK
  String? string; // 사진 URL
  String? field2; // 기구명
  String? field3; // 기구설명
  int? field4; // 카테고리
  String? field5; // 메뉴얼 URL : manualUrl
  String? field6; // 영상 자료 URL : videoUrl
  BigInt? bookmarkId; // 북마크PLK
  BigInt? routineId; // 루틴 PK

  SportsEquipment({
    required this.key,
    this.string,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.bookmarkId,
    this.routineId,
  });
}

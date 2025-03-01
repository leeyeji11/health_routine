import 'package:health_routine/domain/entities/routine.dart';

class RecRoutineMock {
  static final List<Routine> recRoutineMock = [
    // 🔹 초급 루틴 (easy)
    Routine(
      routineId: BigInt.from(1),
      title: "초급 스트레칭",
      description: "초보자를 위한 가벼운 전신 스트레칭.",
      time: 10,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.easy,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(101),
    ),
    Routine(
      routineId: BigInt.from(2),
      title: "초급 상체 운동",
      description: "기초적인 덤벨을 이용한 상체 근력 운동.",
      time: 20,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/lat_pull_down.png",
      difficulty: Difficulty.easy,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(102),
    ),
    Routine(
      routineId: BigInt.from(3),
      title: "초급 하체 운동",
      description: "스쿼트와 런지를 활용한 하체 기초 운동.",
      time: 20,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/squat.png",
      difficulty: Difficulty.easy,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(103),
    ),
    Routine(
      routineId: BigInt.from(4),
      title: "초급 유산소 운동",
      description: "기초적인 유산소 운동으로 가볍게 몸풀기.",
      time: 15,
      category: Category.cardio, // 유산소 운동
      image: "assets/images/workout/running1.png",
      difficulty: Difficulty.easy,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(104),
    ),

    // 🔹 중급 루틴 (medium)
    Routine(
      routineId: BigInt.from(5),
      title: "중급 스트레칭",
      description: "근육 유연성을 높이는 중급 스트레칭.",
      time: 15,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.medium,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(105),
    ),
    Routine(
      routineId: BigInt.from(6),
      title: "중급 상체 운동",
      description: "벤치프레스와 푸쉬업을 활용한 상체 운동.",
      time: 40,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/lat_pull_down.png",
      difficulty: Difficulty.medium,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(106),
    ),
    Routine(
      routineId: BigInt.from(7),
      title: "중급 하체 운동",
      description: "스쿼트와 데드리프트를 포함한 중급 하체 운동.",
      time: 45,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/squat.png",
      difficulty: Difficulty.medium,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(107),
    ),
    Routine(
      routineId: BigInt.from(8),
      title: "중급 유산소 운동",
      description: "지구력을 향상시키는 러닝과 점프 운동.",
      time: 30,
      category: Category.cardio, // 유산소 운동
      image: "assets/images/workout/running1.png",
      difficulty: Difficulty.medium,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(108),
    ),

    // 🔹 상급 루틴 (hard)
    Routine(
      routineId: BigInt.from(9),
      title: "상급 스트레칭",
      description: "고강도 운동 후 회복을 위한 깊은 스트레칭.",
      time: 20,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.hard,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(109),
    ),
    Routine(
      routineId: BigInt.from(10),
      title: "상급 상체 운동",
      description: "고중량 웨이트 트레이닝을 포함한 상체 운동.",
      time: 60,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/lat_pull_down.png",
      difficulty: Difficulty.hard,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(110),
    ),
    Routine(
      routineId: BigInt.from(11),
      title: "상급 하체 운동",
      description: "고중량 스쿼트와 런지를 활용한 하체 강화 루틴.",
      time: 60,
      category: Category.strength, // 근력 운동
      image: "assets/images/workout/squat.png",
      difficulty: Difficulty.hard,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(111),
    ),
    Routine(
      routineId: BigInt.from(12),
      title: "상급 유산소 운동",
      description: "HIIT(고강도 인터벌 트레이닝) 유산소 루틴.",
      time: 45,
      category: Category.cardio, // 유산소 운동
      image: "assets/images/workout/running1.png",
      difficulty: Difficulty.hard,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(112),
    ),

    // 🔹 스트레칭 루틴 (stretching)
    Routine(
      routineId: BigInt.from(13),
      title: "기본 스트레칭",
      description: "운동 전후 필수 기본 스트레칭 루틴.",
      time: 10,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.stretching,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(113),
    ),
    Routine(
      routineId: BigInt.from(14),
      title: "요가 스트레칭",
      description: "요가 동작을 활용한 심신 안정 스트레칭.",
      time: 20,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.stretching,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(114),
    ),
    Routine(
      routineId: BigInt.from(15),
      title: "근막 이완 스트레칭",
      description: "폼롤러를 이용한 근막 이완 스트레칭.",
      time: 25,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.stretching,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(115),
    ),
    Routine(
      routineId: BigInt.from(16),
      title: "전신 릴렉스 스트레칭",
      description: "긴장된 근육을 풀어주는 릴렉스 스트레칭.",
      time: 30,
      category: Category.flexibility, // 유연성 운동
      image: "assets/images/workout/stretching.png",
      difficulty: Difficulty.stretching,
      startDate: DateTime(2024, 2, 27),
      bookmarkId: BigInt.from(116),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:health_routine/services/firebase_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:health_routine/data/routine_mock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month; // 기본값: 월별 달력
  bool _isCollapsed = false; // 달력이 축소되었는지 여부
  // 날짜별 routines를 저장할 Map
  Map<DateTime, List<Map<String, dynamic>>> routinesByDate = {};
  List<Map<String, dynamic>> selectedDayRoutines = [];

  double _getCalendarHeight(DateTime focusedDay) {
    // 🟢 해당 달의 첫째 날과 마지막 날 가져오기
    DateTime firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    DateTime lastDayOfMonth =
        DateTime(focusedDay.year, focusedDay.month + 1, 0);

    // 🟢 해당 달의 시작 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)
    int firstWeekday = firstDayOfMonth.weekday;

    // 🟢 시작 요일을 기준으로 첫 주의 시작을 계산
    int daysBeforeFirstDay = (firstWeekday - 7) % 7;
    int totalDays = lastDayOfMonth.day;

    // 🟢 해당 달의 총 주 수 계산
    int numberOfWeeks = ((daysBeforeFirstDay + totalDays) / 7).ceil();

    // 🟢 주 수에 따라 달력 높이 반환
    if (numberOfWeeks == 6) {
      return MediaQuery.of(context).size.height * 0.9; // 🟢 6주일 때 높이
    } else {
      return MediaQuery.of(context).size.height * 0.45; // 🟢 5주 이하일 때 높이
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAndGroupRoutines();
  }

  void _loadAndGroupRoutines() async {
    var routines = await RoutineService().getAllRoutines();
    routinesByDate.clear();

    for (var routine in routines) {
      if (routine['startDate'] == null) {
        continue;
      }

      DateTime routineDate = (routine['startDate'] as Timestamp).toDate();
      DateTime dateKey = DateTime.utc(
        routineDate.year,
        routineDate.month,
        routineDate.day,
      );

      if (routinesByDate[dateKey] == null) {
        routinesByDate[dateKey] = [];
      }

      routinesByDate[dateKey]!.add(routine);
    }

    print("최종 routinesByDate 데이터: $routinesByDate");

    for (var routine in routines) {
      print("개별 routine 날짜 데이터: ${routine['startDate']}");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Map<String, dynamic>>> routines =
        RoutineMock.routineLists;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  //📌 Dynamic Calendar block
                  Text(
                    "${_selectedDay.month}월 ${_selectedDay.day}일",
                    style: AppTextStyle.moreButton,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Todo: 플래너 추가 스크린으로 이동
                      context.push('/plan-form-edit');
                    },
                  ),
                ],
              ),
              _buildCalendar(),
              //📌 calendar plan list block
              Flexible(
                fit: FlexFit.loose,
                child: RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () async {
                      setState(() {
                        _isCollapsed = false;
                        _calendarFormat = CalendarFormat.month; // 월별 달력으로 변경
                      });
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(), // 스크롤 비활성화
                      itemCount: selectedDayRoutines.isEmpty
                          ? 1
                          : selectedDayRoutines.length,
                      itemBuilder: (context, index) {
                        if (selectedDayRoutines.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("일정이 없습니다.",
                                  style: AppTextStyle.moreButton),
                            ),
                          );
                        }

                        // ✅ 선택한 날짜의 루틴 데이터 가져오기
                        final dayRoutine = selectedDayRoutines[index];

                        return rutineCard(
                          dayRoutine,
                          () {
                            setState(() {
                              selectedDayRoutines.removeAt(index);
                            });
                          },
                          () {
                            setState(() {
                              dayRoutine["isFavorite"] =
                                  !(dayRoutine["isFavorite"] ?? false);
                            });
                          },
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isCollapsed
          ? MediaQuery.of(context).size.height * 0.2
          : (_calendarFormat == CalendarFormat.month
              ? _getCalendarHeight(_selectedDay)
              : MediaQuery.of(context).size.height * 0.3),
      child: TableCalendar(
        eventLoader: (day) {
          return routinesByDate[DateTime.utc(day.year, day.month, day.day)] ??
              [];
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
        ),
        focusedDay: _selectedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekHeight: 30,
        rowHeight: 50,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _calendarFormat = CalendarFormat.week;
            _isCollapsed = true;
            selectedDayRoutines = routinesByDate[DateTime.utc(
                    selectedDay.year, selectedDay.month, selectedDay.day)] ??
                [];
          });
        },
        headerVisible: false,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            bool isToday = isSameDay(day, DateTime.now());
            bool isSelected = isSameDay(_selectedDay, day);

            return Container(
              alignment: Alignment.center,
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? AppColors.white
                      : isToday
                          ? AppColors.primaryColor
                          : AppColors.black,
                  fontWeight: isSelected || isToday
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            bool isSelected = isSameDay(_selectedDay, day);
            if (isSelected) {
              return null;
            }

            return Container(
              alignment: Alignment.center,
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget rutineCard(Map<String, dynamic> routine, VoidCallback onDelete,
      VoidCallback onFavoriteToggle) {
    return Dismissible(
      key: ValueKey(routine["id"] ?? UniqueKey()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Assets.icons.bin.svg(width: 30, height: 30),
      ),
      onDismissed: (direction) {
        onDelete();
        RoutineService().deleteRoutine(routine["id"]);
      },
      child: Stack(
        children: [
          // 배경 이미지 + 색상 오버레이 적용
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.teal.withOpacity(0.5), // ✅ 원하는 색상 & 투명도 설정
                  BlendMode.srcATop, // ✅ 이미지와 색상을 자연스럽게 합성
                ),
                child: routine["image"] != null &&
                        routine["image"].toString().isNotEmpty
                    ? Image.network(
                        routine["image"],
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/workout/running1.png",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          // 텍스트 & 아이콘
          Positioned(
            bottom: 16, // 카드의 하단에서 16px 위로 위치
            left: 16, // 왼쪽에서 16px 띄우기
            right: 16, // 오른쪽에서도 여백 맞추기 (너무 넓어지지 않도록)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Column 크기를 내용 크기에 맞춤
              children: [
                Text(
                  routine["title"] ?? "운동 없음",
                  style: AppTextStyle.calendarCardTitle,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text("${routine["sets"] ?? 1} 세트",
                        style: AppTextStyle.calendarCardSets),
                    SizedBox(width: 8),
                    // ✅ 태그 리스트를 Row로 나열 (Wrap 제거)
                    Row(
                      children: routine["tags"] != null
                          ? List<String>.from(routine["tags"])
                              .take(2)
                              .map((tag) => Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0), // 태그 간 여백 추가
                                    child: _buildTag(tag),
                                  ))
                              .toList()
                          : [],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 즐겨찾기 버튼 (오른쪽 상단)
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                (routine["isFavorite"] ?? false)
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.white,
              ),
              onPressed: onFavoriteToggle, // Todo : 진짜 데이터가 삭제되게 구현
            ),
          ),
        ],
      ),
    );
  }

// ✅ 개별 태그 위젯
  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20), // ✅ 크기 조정
      decoration: BoxDecoration(
        color: Colors.white, // ✅ 배경색 유지
        borderRadius: BorderRadius.circular(20), // ✅ 둥근 모양으로 변경
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // ✅ 그림자 추가
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(tag, style: AppTextStyle.calendarCardTag),
    );
  }
}

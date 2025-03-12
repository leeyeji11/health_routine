import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class PlanFormEditScreen extends StatefulWidget {
  const PlanFormEditScreen({super.key});

  @override
  State<PlanFormEditScreen> createState() => _PlanFormEditScreenState();
}

class _PlanFormEditScreenState extends State<PlanFormEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  File? _selectedImage;
  List<String> _categories = []; // 카테고리 리스트 추가

  Future<String?> _uploadImageToFirebase(File image) async {
    try {
      String fileName = "${const Uuid().v4()}_${basename(image.path)}";
      Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
      print("Firebase 업로드 경로: images/$fileName"); // 추가된 로그 ✅
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("이미지 업로드 성공: $downloadUrl"); // Debug log
      return downloadUrl;
    } catch (e) {
      print("이미지 업로드 실패: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    void _saveRoutineToFirestore() async {
      if (_titleController.text.isEmpty ||
          _timeController.text.isEmpty ||
          _setsController.text.isEmpty ||
          _startDate == null ||
          _endDate == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("모든 필드를 입력하세요!")),
          );
        }
        return;
      }

      String bookmarkId = const Uuid().v4();
      String routineId = const Uuid().v4();
      String? imageUrl;

      if (_selectedImage != null) {
        print("이미지 업로드 시작..."); // Debug log
        imageUrl = await _uploadImageToFirebase(_selectedImage!);

        if (imageUrl == null || imageUrl.isEmpty) {
          print("🚨 이미지 업로드 실패: Firestore 저장 취소");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("이미지 업로드에 실패했습니다.")),
          );
          imageUrl = ""; // 이미지 없이 계속 진행
        }
      }

      if (!mounted) return; // ✅ context 유효성 체크

      try {
        print("📌 Firestore 저장 시작...");
        await FirebaseFirestore.instance.collection('routines').add({
          "bookmarkId": bookmarkId,
          "routineId": routineId,
          "category": _categories,
          "createAt": Timestamp.now(),
          "endDate": Timestamp.fromDate(_endDate!),
          "image": imageUrl ?? "", // 여기서 빈 문자열 대신 `null`로 저장 가능
          "sests": _setsController.text,
          "startDate": Timestamp.fromDate(_startDate!),
          "time": _timeController.text,
          "title": _titleController.text,
          "updateAt": Timestamp.now(),
        });
        print("✅ Firestore 저장 완료");

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("운동 계획이 저장되었습니다!")),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        print("❌ Firestore 저장 실패: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("저장 실패: $e")),
          );
        }
      }
    }

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }

    Future<void> _pickDateRange() async {
      DateTime? startPicked = await showDatePicker(
        context: context,
        initialDate: _startDate ?? DateTime.now(),
        firstDate: DateTime(2024, 1, 1),
        lastDate: DateTime(2030, 12, 31),
      );

      if (startPicked != null) {
        DateTime? endPicked = await showDatePicker(
          context: context,
          initialDate: startPicked,
          firstDate: startPicked,
          lastDate: DateTime(2030, 12, 31),
        );

        if (endPicked != null) {
          setState(() {
            _startDate = startPicked;
            _endDate = endPicked;
          });
        }
      }
    }

    Widget _buildDateRangeBox() {
      String text = (_startDate != null && _endDate != null)
          ? "${_startDate!.month}월 ${_startDate!.day}일 - ${_endDate!.month}월 ${_endDate!.day}일"
          : "날짜 선택";

      return GestureDetector(
        onTap: _pickDateRange, // 한 번의 클릭으로 시작/종료 날짜 선택
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFDAEDED)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.calendar_today, color: Color(0xFF54D6B8)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Future<void> _pickTimeDialog() async {
      TimeOfDay? startPicked = await showTimePicker(
        context: context,
        initialTime: _startTime ?? TimeOfDay.now(),
      );

      if (startPicked != null) {
        TimeOfDay? endPicked = await showTimePicker(
          context: context,
          initialTime: _endTime ?? startPicked,
        );

        if (endPicked != null) {
          setState(() {
            _startTime = startPicked;
            _endTime = endPicked;
          });
        }
      }
    }

    void _showCategoryDialog() {
      TextEditingController categoryController = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("카테고리 추가"),
            content: TextField(
              controller: categoryController,
              decoration: InputDecoration(hintText: "카테고리를 입력하세요"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("취소"),
              ),
              TextButton(
                onPressed: () {
                  if (categoryController.text.isNotEmpty) {
                    setState(() {
                      _categories.add(categoryController.text);
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text("추가"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF2F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F7F7),
        elevation: 0,
        title: Text("플래너 편집", style: AppTextStyle.appBarTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF201600)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 운동 이미지
                Container(
                  width: double.infinity,
                  height: 189,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                                "assets/images/start_page/hr_splash.png"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 운동 제목 입력
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "타이틀 입력",
                    labelStyle: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey, // 라벨 색상
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F7F7), // 배경 색상
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDAEDED)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDAEDED)),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black, // 입력 텍스트 색상
                  ),
                ),

                // 날짜 선택
                const Text(
                  "날짜",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDateRangeBox(), // 날짜 범위를 표시하는 하나의 텍스트 박스

                const SizedBox(height: 16),

                // 시간 & 세트 선택
                const Text(
                  "시간/세트",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildSelectableBox(_timeController, true),
                    SizedBox(width: 8),
                    SizedBox(child: Assets.icons.watch.svg()),
                    const SizedBox(width: 16),
                    _buildSelectableBox(_setsController, false),
                    SizedBox(width: 8),
                    Icon(Icons.check, color: AppColors.primaryColor)
                  ],
                ),

                const SizedBox(height: 16),

                // 카테고리
                const Text(
                  "카테고리",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8.0, // Horizontal space between categories
                        runSpacing:
                            4.0, // Vertical space between lines if wrapped
                        children: _categories
                            .map((category) => _buildCategoryTag(category))
                            .toList(),
                      ),
                    ),
                    TextButton(
                      onPressed: _showCategoryDialog, // 다이얼로그 띄우기
                      child: Text(
                        "+",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 운동 계획 세우기 버튼
                Center(
                  child: ElevatedButton(
                    onPressed: _saveRoutineToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF54D6B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      "운동 계획 세우기",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 선택 가능한 버튼 스타일 박스 (시간, 세트)
  Widget _buildSelectableBox(
    TextEditingController controller,
    bool isTime,
  ) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFFDAEDED),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty && int.tryParse(value) != null) {
            String newValue = "$value ${isTime ? '분' : '세트'}";
            controller.value = TextEditingValue(
              text: newValue,
              selection: TextSelection.fromPosition(
                TextPosition(offset: value.length),
              ),
            );
          } else {
            controller.value = TextEditingValue(
              text: value,
              selection: TextSelection.fromPosition(
                TextPosition(offset: value.length),
              ),
            );
          }
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          hintText: isTime ? "분" : "세트",
          hintStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
    );
  }

  // 카테고리 태그
  Widget _buildCategoryTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFDEF0EC),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
    );
  }
}

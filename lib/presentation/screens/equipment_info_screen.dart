import 'dart:io'; // 추가해야 File을 사용할 수 있음
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:health_routine/services/ml_kit_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EquipmentInfoScreen extends StatefulWidget {
  final String imagePath;
  const EquipmentInfoScreen({super.key, required this.imagePath});

  @override
  _EquipmentInfoScreenState createState() => _EquipmentInfoScreenState();
}

class _EquipmentInfoScreenState extends State<EquipmentInfoScreen> {
  final MLKitService _mlKitService = MLKitService();

  // ✅ Add instance variables
  String detectedEquipment = "분석 중...";
  String equipmentDescription = "설명이 없습니다.";
  List<String> equipmentCategories = [];
  Map<String, dynamic> equipmentManual = {};
  List<String> videoUrls = [];
  String imageUrl = "";
  String formattedDescription = "매뉴얼 설명이 없습니다.";
  String realName = '';

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    print("🔥 이미지 분석 시작: ${widget.imagePath}");

    final result =
        await _mlKitService.analyzeImageAndFetchEquipment(widget.imagePath);

    print("ML Kit 분석 결과: $result");

    if (result != null) {
      setState(() {
        detectedEquipment = result["realName"] ?? result["name"] ?? "알 수 없는 기구";
        equipmentDescription = result["description"] ?? "설명이 없습니다.";
        equipmentCategories = List<String>.from(result["categories"] ?? []);
        equipmentManual = Map<String, dynamic>.from(result["manual"] ?? {});
        formattedDescription =
            (equipmentManual['description'] ?? '매뉴얼 설명이 없습니다.')
                .replaceAll('. ', '.\n');
        videoUrls = List<String>.from(result["videoUrls"] ?? []);
        imageUrl = result["imageUrl"] ?? "";
      });
    } else {
      print("❌ ML Kit이 이미지를 분석하지 못했습니다.");
      setState(() {
        detectedEquipment = "인식 실패";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.pop();
              context.go('/');
            },
          ),
          title: Text(
            '기구 정보',
            style: AppTextStyle.appBarTitle,
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 기구 이미지
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (widget.imagePath.isNotEmpty &&
                            widget.imagePath != '')
                        ? FileImage(File(widget.imagePath)) // 촬영한 이미지 적용
                        : AssetImage('assets/images/equipment/trade_mill.png')
                            as ImageProvider, // 기본 이미지
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 기구 제목
            Center(
              child: Text(
                detectedEquipment,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ 기구 설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                equipmentDescription,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 카테고리 태그 (유산소 운동)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: equipmentCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0), // 간격 조절
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFDEF0EC),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/bookmark_selected.svg',
                    height: 30,
                    width: 30,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            // ✅ 매뉴얼 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                '매뉴얼',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      spreadRadius: 2),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(equipmentManual['image'] ??
                              'https://via.placeholder.com/150'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        formattedDescription,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ 영상 자료 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                '영상 자료',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Column(
              children: videoUrls.map((videoUrl) {
                String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: videoId ?? '',
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

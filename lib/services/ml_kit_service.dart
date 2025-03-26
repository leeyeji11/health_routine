import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MLKitService {
  final ImageLabeler imageLabeler;

  /// ✅ ML Kit의 ImageLabeler 초기화 (클라우드 모델 옵션 제거)
  MLKitService() : imageLabeler = _initializeImageLabeler();

  /// ✅ 클라우드 모델 옵션 제거 및 기본 모델 사용
  static ImageLabeler _initializeImageLabeler() {
    try {
      return ImageLabeler(
        options: ImageLabelerOptions(
          confidenceThreshold: 0.7, // ✅ 로컬 모델 사용
        ),
      );
    } catch (e) {
      debugPrint("❌ ML Kit 초기화 오류 발생: $e");
      throw e;
    }
  }

  /// 🔍 **이미지 분석 후 Firestore에서 운동기구 데이터 조회 & 감지된 데이터 저장**
  Future<Map<String, dynamic>?> analyzeImageAndFetchEquipment(
      String imagePath) async {
    try {
      debugPrint("🔥 ML Kit 분석 시작: $imagePath");

      final inputImage = InputImage.fromFile(File(imagePath));
      final List<ImageLabel> labels =
          await imageLabeler.processImage(inputImage);

      if (labels.isNotEmpty) {
        String detectedLabel = labels.first.label.toLowerCase();
        debugPrint("✅ 감지된 운동기구: $detectedLabel");

        // ✅ Firestore에서 해당 운동기구 정보 조회
        final equipmentData = await fetchEquipmentInfo(detectedLabel);

        // ✅ Firestore에 감지된 객체 데이터 저장
        await saveDetectedObjectToFirestore(detectedLabel);

        return equipmentData;
      } else {
        debugPrint("❌ 운동기구를 감지하지 못했습니다.");
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint("❌ ML Kit 분석 중 오류 발생: $e");
      debugPrint("📌 스택 트레이스: $stackTrace");
      return null;
    }
  }

  /// 🔥 **Firestore에서 감지된 라벨과 일치하는 운동기구 데이터 가져오기**
  Future<Map<String, dynamic>?> fetchEquipmentInfo(String label) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('sports_equipments')
        .where('name', isGreaterThanOrEqualTo: label)
        .where('name', isLessThanOrEqualTo: label + '\uf8ff') // 🔍 유사한 라벨 검색
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var equipmentData = querySnapshot.docs.first.data();

      return {
        "name": equipmentData["name"],
        "description": equipmentData["description"],
        "categories": equipmentData["category"],
        "manual": {
          "description": equipmentData["manual"]["description"],
          "image": equipmentData["manual"]["image"],
        },
        "videoUrls": equipmentData["videoUrl"],
        "imageUrl": equipmentData["url"],
        "bookmarkId": equipmentData["bookmarkId"],
        "routineId": equipmentData["routineId"],
        "realName": equipmentData["realName"]
      };
    } else {
      debugPrint("❌ Firestore에서 일치하는 운동기구를 찾을 수 없습니다.");
      return null;
    }
  }

  /// 🔥 **감지된 객체 데이터를 Firestore에 저장**
  Future<void> saveDetectedObjectToFirestore(String detectedLabel) async {
    try {
      await FirebaseFirestore.instance.collection('detected_objects').add({
        "label": detectedLabel,
        "timestamp": FieldValue.serverTimestamp(),
      });
      debugPrint("✅ Firestore에 감지된 객체 저장 완료: $detectedLabel");
    } catch (e) {
      debugPrint("❌ Firestore에 감지된 객체 저장 중 오류 발생: $e");
    }
  }

  /// ✅ ML Kit 리소스 해제 메서드
  void dispose() {
    imageLabeler.close();
  }
}

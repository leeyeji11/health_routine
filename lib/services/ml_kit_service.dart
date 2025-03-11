// Google ML Kit의 이미지 라벨링 패키지 사용
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

// ✅ MLKitService 클래스: Google ML Kit을 이용한 이미지 분석 기능 제공
class MLKitService {
  final ImageLabeler imageLabeler; // ML Kit의 이미지 라벨링 객체

  // ✅ 생성자: ML Kit의 ImageLabeler를 초기화
  MLKitService()
      : imageLabeler = ImageLabeler(
          options: ImageLabelerOptions(
              confidenceThreshold: 0.7), // 신뢰도 임계값 설정 (0.7 이상만 인식)
        );

  // ✅ 이미지 분석을 수행하는 메서드
  // 사용자가 전달한 이미지 경로를 이용해 기구(장비) 감지
  Future<String?> detectEquipment(String imagePath) async {
    final inputImage =
        InputImage.fromFilePath(imagePath); // 이미지 파일을 ML Kit이 읽을 수 있는 형식으로 변환
    final labels =
        await imageLabeler.processImage(inputImage); // ML Kit을 이용해 이미지 분석 수행

    if (labels.isNotEmpty) {
      return labels
          .first.label; // 가장 신뢰도가 높은 라벨 반환 (예: "treadmill", "dumbbell")
    }
    return null; // 인식된 라벨이 없을 경우 null 반환
  }

  // ✅ 리소스 해제 메서드
  // ML Kit의 리소스를 해제하는 역할
  void dispose() {
    imageLabeler.close();
  }
}

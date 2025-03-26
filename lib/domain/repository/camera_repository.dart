import 'package:camera/camera.dart';

// 📷 CameraRepository (카메라 기능을 정의하는 인터페이스)
// 📌 역할 : UseCase에서 호출

abstract class CameraRepository {
  // 📌 카메라를 초기화하는 메서드
  // - 사용 가능한 카메라를 가져와서 초기화
  // - 성공하면 CameraController 반환, 실패하면 null 반환
  Future<CameraController?> initializeCamera();

  /// 📌 사진을 촬영하는 메서드
  /// - 촬영한 사진의 파일 경로(String)를 반환
  /// - 촬영할 수 없는 경우 null 반환
  Future<String?> takePicture();

  /// 📌 카메라 리소스를 해제하는 메서드
  /// - 메모리 누수를 방지하기 위해 컨트롤러를 해제
  void disposeCamera();
}

// 카메라 기능을 직접 제어하는 DataSource를 만든다.
import 'package:camera/camera.dart';

/// 📷 CameraDataSource 클래스: 카메라를 관리하는 데이터 소스
class CameraDataSource {
  // 📌 카메라 컨트롤러 (카메라를 제어하는 객체)
  CameraController? _controller;
  // 📌 사용 가능한 카메라 목록을 저장하는 리스트
  List<CameraDescription> _cameras = [];

  Future<CameraController?> initializeCamera() async {
    // 사용 가능한 카메라 가져오기
    _cameras = await availableCameras();
    // 카메라가 하나 이상 있는 경우만 실행
    if (_cameras.isNotEmpty) {
      // 첫 번째 카메라 선택 (보통 후면 카메라)
      _controller = CameraController(
        _cameras[0],
        // 해상도를 높게 설정
        ResolutionPreset.high,
        // 오디오 녹음 비활성화
        enableAudio: false,
      );
      // 카메라 초기화
      await _controller!.initialize();
      // 초기화된 컨트롤러 반환
      return _controller;
    }
    // 사용 가능한 카메라가 없을 경우 null 반환
    return null;
  }

  /// 📌 사진 촬영 함수
  Future<String?> takePicture() async {
    // 카메라가 초기화되지 않았거나 컨트롤러가 없으면 null 반환
    if (_controller == null || !_controller!.value.isInitialized) return null;

    // 사진 촬영
    final XFile image = await _controller!.takePicture();
    // 촬영된 이미지 파일 경로 반환
    return image.path;
  }

  /// 📌 카메라 정리 함수
  void disposeCamera() {
    _controller?.dispose();
    _controller = null;
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../domain/usecases/initialize_camera_usecase.dart';
import '../../domain/usecases/take_picture_usecase.dart';

/// 📌 InstrumentScanViewModel: 카메라 스캔 기능을 위한 ViewModel
/// - ChangeNotifier를 상속받아 상태 변화를 UI에 반영할 수 있도록 함
class InstrumentScanViewModel extends ChangeNotifier {
  // 📌 유즈케이스(Use Case) 의존성 주입
  final InitializeCameraUseCase _initializeCameraUseCase;
  final TakePictureUseCase _takePictureUseCase;

  // 📌 카메라 컨트롤러 및 상태 변수
  CameraController? _controller; // 카메라 컨트롤러
  bool isCameraInitialized = false; // 카메라 초기화 여부

  // 📌 외부에서 컨트롤러를 읽을 수 있도록 Getter 제공
  CameraController? get controller => _controller;

  /// 📌 생성자: 유즈케이스를 주입받음 (의존성 주입)
  InstrumentScanViewModel(
    this._initializeCameraUseCase,
    this._takePictureUseCase,
  );

  /// 📸 카메라 초기화 메서드
  Future<void> initializeCamera() async {
    _controller = await _initializeCameraUseCase(); // 카메라 초기화 실행
    if (_controller != null) {
      isCameraInitialized = true; // 초기화 성공 시 상태 변경
      notifyListeners(); // UI 업데이트
    }
  }

  /// 📸 사진 촬영 메서드
  Future<String?> takePicture() async {
    return await _takePictureUseCase();
  }

  /// 🚀 카메라 해제 메서드
  void disposeCamera() {
    _controller?.dispose(); // 카메라 컨트롤러 해제
    _controller = null;
    isCameraInitialized = false;
    notifyListeners(); // UI 업데이트
  }
}

import 'package:camera/camera.dart';
import 'package:health_routine/domain/repository/camera_repository.dart';

/// 📷 카메라 초기화 유즈케이스 (Use Case)
/// - CameraRepository를 통해 카메라를 초기화하는 역할
class InitializeCameraUseCase {
  // 📌 카메라 기능을 제공하는 저장소 (CameraRepository)
  final CameraRepository repository;

  /// 📌 생성자 (CameraRepository를 주입받음)
  InitializeCameraUseCase(this.repository);

  /// 📌 카메라를 초기화하는 메서드 (함수 호출처럼 사용할 수 있도록 call() 메서드 정의)
  Future<CameraController?> call() {
    return repository.initializeCamera();
  }
}

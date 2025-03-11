import 'package:health_routine/domain/repository/camera_repository.dart';

/// 📸 사진 촬영 유즈케이스 (Use Case)
/// - CameraRepository를 통해 사진을 촬영하는 역할
class TakePictureUseCase {
  // 📌 카메라 기능을 제공하는 저장소 (CameraRepository)
  final CameraRepository repository;

  /// 📌 생성자 (CameraRepository를 주입받음)
  TakePictureUseCase(this.repository);

  /// 📌 사진 촬영 메서드 (함수 호출처럼 사용 가능)
  Future<String?> call() {
    return repository.takePicture();
  }
}

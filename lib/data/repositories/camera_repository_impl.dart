import 'package:camera/camera.dart';
import 'package:health_routine/data/data_sources/camera_data_source.dart';
import 'package:health_routine/domain/repository/camera_repository.dart';
// Repository 인터페이스를 실제로 구현

/// 📷 CameraRepository의 실제 구현체 (Implementation)
/// - CameraDataSource를 이용하여 카메라 관련 기능을 제공
class CameraRepositoryImpl implements CameraRepository {
  // 📌 CameraDataSource 인스턴스 (카메라 제어를 위한 데이터 소스)
  final CameraDataSource _cameraDataSource;

  /// 📌 생성자 (CameraDataSource를 외부에서 주입받음)
  CameraRepositoryImpl(this._cameraDataSource);

  /// 📌 카메라 초기화 (CameraDataSource에 위임)
  @override
  Future<CameraController?> initializeCamera() {
    return _cameraDataSource.initializeCamera();
  }

  /// 📌 사진 촬영 (CameraDataSource에 위임)
  @override
  Future<String?> takePicture() {
    return _cameraDataSource.takePicture();
  }

  /// 📌 카메라 리소스 해제 (CameraDataSource에 위임)
  @override
  void disposeCamera() {
    _cameraDataSource.disposeCamera();
  }
}

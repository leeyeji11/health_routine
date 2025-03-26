import 'package:firebase_core/firebase_core.dart';
// import 'package:health_routine/services/notification_service.dart';
// import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:health_routine/core/routers.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
// import 'package:health_routine/data/data_sources/camera_data_source.dart';
// import 'package:health_routine/data/repositories/camera_repository_impl.dart';
// import 'package:health_routine/domain/usecases/initialize_camera_usecase.dart';
// import 'package:health_routine/domain/usecases/take_picture_usecase.dart';
// import 'package:health_routine/presentation/viewmodels/instrument_scan_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔔 알림 서비스 초기화
  // final notificationService = NotificationService();
  // await notificationService.initNotifications();

  // 🔥 Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 📷 클린 아키텍처 기반의 DI (의존성 주입)
  // final cameraDataSource = CameraDataSource();
  // final cameraRepository = CameraRepositoryImpl(cameraDataSource);
  // final initializeCameraUseCase = InitializeCameraUseCase(cameraRepository);
  // final takePictureUseCase = TakePictureUseCase(cameraRepository);

  runApp(
    // MultiProvider(
    //   providers: [
    //     // ✅ ViewModel 등록 (CameraProvider 대신 사용)
    //     ChangeNotifierProvider(
    //       create: (_) => InstrumentScanViewModel(
    //         initializeCameraUseCase,
    //         takePictureUseCase,
    //       ),
    //     ),
    //   ],
 HR(),

  );
}

class HR extends StatelessWidget {
  const HR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: AppColors.white,
      title: 'Health Routine',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

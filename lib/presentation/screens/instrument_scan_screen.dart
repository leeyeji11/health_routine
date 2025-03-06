import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';
import 'package:permission_handler/permission_handler.dart';

class InstrumentScanScreen extends StatefulWidget {
  const InstrumentScanScreen({super.key});

  @override
  State<InstrumentScanScreen> createState() => _InstrumentScanScreenState();
}

class _InstrumentScanScreenState extends State<InstrumentScanScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = []; // 사용 가능한 카메라 목록
  bool isCameraInitialized = false; // 카메라 초기화 여부
  bool _showGuide = true; // 가이드 메세지 표시 여부 (3초 후 사라짐)
  bool _isPermissionChecked = false; // 권한 확인 완료 여부

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndInitializeCamera(); // 카메라 권한 체크 및 초기화

    // 3초 후 가이드 메시지 숨기기
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showGuide = false;
        });
      }
    });
  }

  /// ✅ 카메라 및 권한 체크 후 초기화
  Future<void> _checkPermissionsAndInitializeCamera() async {
    final cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      final newStatus = await Permission.camera.request();
      // request() : 카메라 권한을 요청하는 함수
      if (!mounted) return;
      if (newStatus.isGranted) {
        await _initializeCamera();
      }
    } else {
      await _initializeCamera();
    }

    if (mounted) {
      setState(() {
        _isPermissionChecked = true; // 권한 확인 완료
      });
    }
  }

  /// ✅ 카메라 초기화
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras(); // availableCameras()는 현재 기기에 연결된 카메라 목록을 가져오는 함수
      if (_cameras.isNotEmpty) {
        _controller = CameraController(
          _cameras[0], // 첫 번째 카메라 선택
          ResolutionPreset.high, // 고해상도 설정
          enableAudio: false, // 오디오 활성 여부 (마이크 권한 요청 방지)
        );
        await _controller!.initialize();
        if (!mounted) return;
        setState(() {
          isCameraInitialized = true;
        });
      } else {
        debugPrint("Error: No available cameras.");
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  /// ✅ 사진 촬영 기능
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      debugPrint("Error: Camera is not ready.");
      return;
    }
    try {
      final XFile image = await _controller!.takePicture();
      if (!mounted) return;
      context.push('/equipment-info', extra: image.path); // 촬영된 이미지 경로 전달
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  /// ✅ UI 빌드
  @override
  Widget build(BuildContext context) {
    // 권한 확인 중이면 인디케이터 표시
    if (!_isPermissionChecked) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    // ✅ 권한이 없으면 권한 요청 화면 표시
    if (!isCameraInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "📷 카메라 권한이 필요합니다.",
                style: AppTextStyle.cameraDesc,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newStatus = await Permission.camera.request();
                  if (newStatus.isGranted) {
                    _initializeCamera();
                  }
                },
                child: const Text("권한 요청"),
              ),
            ],
          ),
        ),
      );
    }

    // ✅ 카메라 준비 완료 → 카메라 화면 표시
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(_controller!)), // 카메라 화면

          // 상단 아이콘 (AppBar 없이 배치)
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Assets.icons.lightning.svg(width: 32, height: 32),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.cameraSelected.svg(width: 32, height: 32),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.info.svg(width: 32, height: 32),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.cross.svg(width: 32, height: 32),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // 📷 가이드 박스 (카메라 화면 중앙)
          if (_showGuide)
            Center(
              child: Assets.images.camera.cameraArea.svg(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          if(_showGuide)
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "운동 기구를 카메라로 촬영하고",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.cameraDesc,
                  ),
                  Text(
                    "정확한 사용법을 배워요",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.cameraDesc,
                  ),
                ],
              ),
            ),




          // 📷 촬영 버튼 (하단 중앙)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: GestureDetector(
                onTap: _takePicture,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: AppColors.secondColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ 리소스 해제
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
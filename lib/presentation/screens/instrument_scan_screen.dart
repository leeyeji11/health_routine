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
  List<CameraDescription> _cameras = []; // 사용 가능한 카메라 목록 저장 리스트
  bool isCameraInitialized = false;
  bool _showGuide = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showGuide = false;
        });
      }
    });
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _controller = CameraController(
          (_cameras[0]), // 첫 번째 카메라(주로 후면 카메라)를 사용.
          ResolutionPreset.high, // 고해상도로 촬영
        );
        await _controller!.initialize();
        if (!mounted) return;
        setState(() {
          isCameraInitialized = true; // ✅ 카메라 초기화 완료
        });
      } else {
        debugPrint("Error: No available cameras.");
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 카메라가 초기화되기 전까지는 로딩 화면만 표시
    if (!isCameraInitialized) {
      return Scaffold(
        backgroundColor: Colors.black, // 검은 화면 유지
        body: Center(child:  Column(
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
                child: Text("권한 요청"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text("앱 설정에서 권한 허용"),
              ),
            ],
          ),), // 로딩 표시
      );
    }

    // ⭕️ 카메라 준비 됨
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 카메라 화면
          Positioned.fill(child: CameraPreview(_controller!)),

          // **🔹 상단 아이콘을 AppBar 없이 배치**
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Assets.icons.lightning.svg(
                          width: 32,
                          height: 32,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.cameraSelected.svg(
                          width: 32,
                          height: 32,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.info.svg(
                          width: 32,
                          height: 32,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.icons.cross.svg(
                          width: 32,
                          height: 32,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),
                const Spacer(), // **아이콘과 버튼 사이 공간 확보**
              ],
            ),
          ),

          // **🔹 카메라 가이드 박스 (중앙 정렬)**
          if(_showGuide)
          Center(
            child: Assets.images.camera.cameraArea.svg(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.8,
            ),
          ),

          // **🔹 촬영 버튼을 하단 중앙에 배치**
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

          // **🔹 하단 안내 텍스트 (중앙 정렬)**
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
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    // XFile : 사진 파일을 나타내는 객체
    // _controller!.takePicture(); → 사용자가 촬영 버튼을 누르면 사진을 찍음
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}


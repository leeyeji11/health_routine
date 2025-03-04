import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class InstrumentScanScreen extends StatefulWidget {
  const InstrumentScanScreen({super.key});

  @override
  State<InstrumentScanScreen> createState() => _InstrumentScanScreenState();
}

class _InstrumentScanScreenState extends State<InstrumentScanScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = []; // 사용 가능한 카메라 목록 저장 리스트
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // 카메라를 설정
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
        body: Center(child: CircularProgressIndicator()), // 로딩 표시
      );
    }

    // ⭕️ 카메라 준비 됨
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 카메라 화면
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // 상단 아이콘 (플래시, 닫기, 정보)
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width * 0.15, // 왼쪽에서 15% 위치
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/lightning.svg',
                width:
                    MediaQuery.of(context).size.width * 0.08, // 화면 너비 기준 크기 조정
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width * 0.35, // 화면 중앙에 정렬
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/camera_selected.svg',
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 40,
            right: MediaQuery.of(context).size.width * 0.35,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/info.svg',
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              onPressed: () {},
            ),
          ),

          Positioned(
            top: 40,
            right: MediaQuery.of(context).size.width * 0.15,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/cross.svg',
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              onPressed: () => context.pop(),
            ),
          ),

          // 카메라 가이드 박스 (camera_area.svg) - 기존 위치 그대로 유지
          Center(
            child: SvgPicture.asset(
              'assets/images/camera/camera_area.svg',
              width: MediaQuery.of(context).size.width * 0.8, // 화면 크기 조절
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),

          // 촬영 버튼 (camera_area.svg와 별도로 배치)
          Positioned(
            bottom: 60,
            left: MediaQuery.of(context).size.width / 2 - 35, // 화면 중앙 정렬
            child: GestureDetector(
              onTap: _takePicture,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 바깥쪽 촬영 버튼
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: AppColors.secondColor,
                      shape: BoxShape.circle,
                    ),
                  ),

                  // 안쪽 촬영 버튼
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 하단 안내 텍스트 (화면 중앙 배치)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Column이 필요한 크기만큼만 차지하도록 설정
              children: [
                Text("운동 기구를 카메라로 촬영하고",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.cameraDesc),
                Text("정확한 사용법을 배워요",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.cameraDesc),
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

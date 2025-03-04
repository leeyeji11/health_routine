import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InstrumentScanScreen extends StatefulWidget {
  const InstrumentScanScreen({super.key});

  @override
  State<InstrumentScanScreen> createState() => _InstrumentScanScreenState();
}

class _InstrumentScanScreenState extends State<InstrumentScanScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = []; // 사용 가능한 카메라 목록 저장 리스트

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // 카메라를 설정
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    if (_cameras.isEmpty) {
      // 카메라가 없을 경우 예외 처리
      print("Error: No cameras available.");
      return;
    }

    _controller = CameraController(
      _cameras[0], // 첫 번째 카메라(주로 후면 카메라)를 사용.
      ResolutionPreset.high, // 고해상도로 촬영
    );
    await _controller!.initialize(); // 카메라를 실제로 초기화
    setState(() {}); // UI를 새로고침해서 카메라 화면을 표시
  }

  @override
  Widget build(BuildContext context) {
    // ❌ 카메라가 준비되지 않은 경우
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(
        child: _cameras.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("카메라를 사용할 수 없습니다.",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  SizedBox(height: 20),
                  Image.asset('assets/images/camera_no.png',
                      width: 200), // 기본 이미지 표시
                ],
              )
            : CircularProgressIndicator(),
      );
    }

    // ⭕️ 카메라 준비 됨
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!), // 카메라 화면을 보여줌
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              // 촬영 버튼
              onPressed: _takePicture,
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    // XFile : 사진 파일을 나타내는 객체
    // _controller!.takePicture(); → 사용자가 촬영 버튼을 누르면 사진을 찍음
    final XFile image = await _controller!.takePicture();
    // 촬영된 이미지 경로를 '/equipment-info'로 전달
    context.push('/equipment-info', extra: image.path);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

import 'dart:io';
import 'package:path/path.dart';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';

class AttachFileScreen extends StatefulWidget {
  static const routeURL = "/attach";
  static const routeName = "attach";

  const AttachFileScreen({super.key});

  @override
  State<AttachFileScreen> createState() => _AttachFileScreenState();
}

class _AttachFileScreenState extends State<AttachFileScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;
  // late final AnimationController _buttonAnimationController =
  //     AnimationController(
  //   vsync: this,
  //   duration: const Duration(milliseconds: 200),
  // );

  late FlashMode _flashMode;

  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    print("initState");

    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  void dispose() {
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  Future<void> initCamera() async {
    print("initCamera");
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    if (!cameraDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    print("toggleSelfieMode: $_isSelfieMode");
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _takePicture(BuildContext context) async {
    print("takePicture");
    try {
      final XFile file = await _cameraController.takePicture();
      context.pop(file);
    } catch (e) {
      print("사진을 찍을 수 업습니다.\n${e.toString()}");
    }
  }

  bool _isCameraMode = true;
  void _onTapCamera(BuildContext context) {
    setState(() {
      _isCameraMode = true;
    });
  }

  void _onTapLibrary(BuildContext context) {
    setState(() {
      _isCameraMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: !_hasPermission
            ? EmptyScreen()
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  // CameraBackground(),
                  CloseButton(),
                  ControlButtons(
                    takePicture: _takePicture,
                    toggleSelfieMode: _toggleSelfieMode,
                  ),
                  BottomButtons(
                      onTapCamera: (context) => _onTapCamera(context),
                      onTapLibrary: (context) => _onTapLibrary(context),
                      isCameraMode: _isCameraMode),
                ],
              ),
      ),
    );
  }
}

const kBottomControlHeight = 200;

// class CameraBackground extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width,
//       height: size.height,
//       color: Colors.transparent,
//       child: Container(
//         width: size.width,
//         height: size.height - kBottomControlHeight,
//         color: Colors.transparent,
//       ),
//     );
//   }
// }

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Initializing...",
          style: TextStyle(color: Colors.white, fontSize: Sizes.size20),
        ),
        Gaps.v20,
        CircularProgressIndicator.adaptive()
      ],
    );
  }
}

class CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: Sizes.size40,
      left: Sizes.size20,
      child: SizedBox(
        width: size.width,
        height: 50,
        child: GestureDetector(
          onTap: () => context.pop(),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  final void Function(BuildContext) onTapCamera;
  final void Function(BuildContext) onTapLibrary;
  final bool isCameraMode;

  const BottomButtons(
      {super.key,
      required this.onTapCamera,
      required this.onTapLibrary,
      required this.isCameraMode});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        bottom: 0,
        child: Container(
          width: size.width,
          height: 130,
          color: Colors.black.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.transparent,
                ),
              ),
              GestureDetector(
                onTap: () => onTapCamera(context),
                child: Text(
                  "Camera",
                  style: context.buttonTitle!.copyWith(
                      color: isCameraMode ? Colors.white : Colors.grey),
                ),
              ),
              Gaps.h60,
              GestureDetector(
                onTap: () => onTapLibrary(context),
                child: Text(
                  "Library",
                  style: context.buttonTitle!.copyWith(
                      color: !isCameraMode ? Colors.white : Colors.grey),
                ),
              ),
              Gaps.h52,
            ],
          ),
        ));
  }
}

class ControlButtons extends StatelessWidget {
  final Function takePicture;
  final Function toggleSelfieMode;

  const ControlButtons(
      {super.key, required this.takePicture, required this.toggleSelfieMode});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 130,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: size.width,
          height: 80,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.boltLightning,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => takePicture(context),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white),
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.black, width: 6),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => toggleSelfieMode,
                  child: const FaIcon(
                    FontAwesomeIcons.rotate,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

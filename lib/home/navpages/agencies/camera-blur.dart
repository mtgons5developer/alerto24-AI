import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

FaceDetector faceDetector = GoogleMlKit.vision.faceDetector();

void processFrame(CameraImage image) async {
    final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.Rotation_0deg,
        inputImageFormat: InputImageFormat.yuv420
      ),
    );
  
    final faces = await faceDetector.processImage(inputImage);
  
    // Apply blurring to detected faces
    // ...
  
    // Display the processed frame
    // ...
  }
  
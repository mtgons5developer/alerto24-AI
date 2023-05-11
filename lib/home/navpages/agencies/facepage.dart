import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:alerto24/vdv/painters/entity_extraction_view.dart';
import 'package:alerto24/vdv/painters/language_identifier_view.dart';
import 'package:alerto24/vdv/painters/language_translator_view.dart';
import 'package:alerto24/vdv/painters/smart_reply_view.dart';
import 'package:alerto24/vdv/painters/face_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text('Vision APIs'),
                    children: [
                      // CustomCard('Barcode Scanning', BarcodeScannerView()),
                      CustomCard('Face Detection', FaceDetectorView()),
                      // CustomCard('Image Labeling', ImageLabelView()),
                      // CustomCard('Object Detection', ObjectDetectorView()),
                      // CustomCard('Text Recognition', TextRecognizerView()),
                      // CustomCard('Digital Ink Recognition', DigitalInkView()),
                      // CustomCard('Pose Detection', PoseDetectorView()),
                      // CustomCard('Selfie Segmentation', SelfieSegmenterView()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ExpansionTile(
                    title: const Text('Natural Language APIs'),
                    children: [
                      CustomCard('Language ID', LanguageIdentifierView()),
                      CustomCard(
                          'On-device Translation', LanguageTranslatorView()),
                      CustomCard('Smart Reply', SmartReplyView()),
                      CustomCard('Entity Extraction', EntityExtractionView()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}

// import 'dart:html';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// class FacePage extends StatefulWidget {
//   const FacePage({super.key});

//     @override
//     createState() => _FacePageState();
// }

// class _FacePageState extends State<FacePage> {
//     File _imageFile;
//     List<Face> _faces;

//     void _getImageAndDetectFaces() async {
//       final imageFile = await ImagePicker.pickImage(
//         source: ImageSource.gallery,
//       );
//       final image = FirebaseVisionImage.fromFile(imageFile);
//       final FaceDetector = FirebaseVision.instance.FaceDetector(
//         FaceDetectorOptions(
//           mode: FaceDetectorMode.accurate,
//         ),
//       );
//       await FaceDetector.detectInImage(image);
//       setState(() {
//         _imageFile = imageFile;
//         _faces = faces;
//       });
//     }
//     @override
//     Widget build(BuildContext context) {        
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Face Detection'),
//         ),
//         body: Container(),

//         floatingActionButton: FloatingActionButton(
//           onPressed: _getImageAndDetectFaces,
//           tooltip: 'Pick an Image',
//           child: const Icon(Icons.add_a_photo),
//         ),
//       );
//     }
// }
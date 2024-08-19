import 'package:celex_ocr_dbd/scanned_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    // Initialize the camera plugin and get the available cameras
    _cameras = await availableCameras();
  }

  void _startCamera() {
    if (_cameras.isNotEmpty) {
      // Here you would navigate to a camera preview page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreviewPage(camera: _cameras[0]),
        ),
      );
    } else {
      // Handle the case where no cameras are available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No cameras available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanner',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 245, 122, 122),
          height: 120,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScannedDetails()));
            },
            child: Text(
              "Start Camera",
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraPreviewPage extends StatelessWidget {
  final CameraDescription camera;

  const CameraPreviewPage({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Preview'),
      ),
      body: Center(
        child: Text('Camera preview for ${camera.name} will go here.'),
      ),
    );
  }
}

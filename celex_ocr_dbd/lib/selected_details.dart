import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:celex_ocr_dbd/Results.dart';
import 'package:img_picker/img_picker.dart'; // Make sure the path is correct

class CameraScreen extends StatefulWidget {
  final int colorValue;
  final int sizeValue;

  const CameraScreen({
    super.key,
    required this.colorValue,
    required this.sizeValue,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Define a map to convert color values to color and name
  Color _getColorFromValue(int value) {
    switch (value) {
      case 1:
        return Colors.white;
      case 2:
        return Color.fromARGB(255, 255, 240, 101); // Yellow
      case 3:
        return Color.fromARGB(255, 126, 240, 130); // Green
      case 4:
        return Colors.black;
      default:
        return Colors.grey; // Default color if no match
    }
  }

  String _getColorNameFromValue(int value) {
    switch (value) {
      case 1:
        return 'White';
      case 2:
        return 'Yellow';
      case 3:
        return 'Green';
      case 4:
        return 'Black';
      default:
        return 'Unknown'; // Default name if no match
    }
  }

  String _getSizeDescription(int sizeValue) {
    switch (sizeValue) {
      case 1:
        return '200 x 100';
      case 2:
        return '285 x 45';
      case 3:
        return '500 x 120';
      case 4:
        return '340 x 200';
      default:
        return 'Unknown Size'; // Default size description if no match
    }
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = _getColorFromValue(widget.colorValue);
    String colorName = _getColorNameFromValue(widget.colorValue);
    String sizeDescription = _getSizeDescription(widget.sizeValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
     const     SizedBox(height: 40), 

          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'HSRP Details',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
       const         SizedBox(height: 10),
                Text(
                  'Color: $colorName',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
        const        SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 30,
                  color: selectedColor,
                ),
       const         SizedBox(height: 10),
                Text(
                  'Size: $sizeDescription',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
    const      SizedBox(height: 20), // Space between container and button

          if (_image != null)
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red, size: 30),
                      onPressed: () {
                        setState(() {
                          _image = null; // Remove the image
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: _openCamera,
                  child: Text(
                    'Open Camera',
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
              ),
            ),
     const     SizedBox(height: 20), // Space between button and next button

          if (_image != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScannedResults()));
              },
              child: Text(
                'Next',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: GoogleFonts.poppins(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}

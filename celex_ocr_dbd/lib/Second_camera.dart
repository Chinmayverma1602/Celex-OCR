import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:img_picker/img_picker.dart';

import 'failure_results.dart';
import 'success_result.dart';

class CameraScreen2 extends StatefulWidget {
  final int colorValue;
  final int sizeValue;

  const CameraScreen2({
    Key? key,
    required this.colorValue,
    required this.sizeValue,
  }) : super(key: key);

  @override
  _CameraScreenState2 createState() => _CameraScreenState2();
}

class _CameraScreenState2 extends State<CameraScreen2> {
  File? _image;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Resize the image to a lower resolution
      final resizedImage = await _resizeImage(File(pickedFile.path));
      setState(() {
        _image = resizedImage;
      });
    }
  }

  Future<File> _resizeImage(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(imageBytes);

    // Resize to a smaller resolution, e.g., 640x480
    final resizedImage =
        img.copyResize(originalImage!, width: 1600, height: 900);

    final tempDir = Directory.systemTemp;
    final resizedImagePath = '${tempDir.path}/resized_image.jpg';
    File(resizedImagePath)
        .writeAsBytesSync(img.encodeJpg(resizedImage, quality: 70));

    return File(resizedImagePath);
  }

  Future<void> postPlateDetails() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    const snackBar = SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Processing...'),
        ],
      ),
      duration: Duration(minutes: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    final url = Uri.parse(
        'https://uat-newmmhsrp.celexhsrp.in/hsrp-ocr/img_ocr_response.php');
    var request = http.MultipartRequest('POST', url);

    request.fields['plate_color'] = widget.colorValue.toString();
    request.fields['plate_size'] = widget.sizeValue.toString();
    request.fields['esm_id'] = "em00001";

    request.files
        .add(await http.MultipartFile.fromPath('attachment', _image!.path));

    try {
      var response = await request.send();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        if (responseData.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Received empty response from server.'),
                duration: Duration(seconds: 2)),
          );
          return;
        }

        final responseJson = jsonDecode(responseData);
        String message = responseJson['message'] ?? '';
        String ocrRegNo = responseJson['ocr_reg_no'] ?? '';
        String ocrLidNo = responseJson['ocr_lid_no'] ?? '';

        if (responseJson['status'] == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SuccessResults(
              regNo: responseJson['reg_no'] ?? '',
              frontLidNo: responseJson['front_lid_no'] ?? '',
              rearLidNo: responseJson['rear_lid_no'] ?? '',
              ocrLidNo: ocrLidNo,
              ocrRegNo: ocrRegNo,
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FailedResults(
              regNo: responseJson['reg_no'] ?? '',
              ocrLidNo: ocrLidNo,
              frontLidNo: responseJson['front_lid_no'] ?? '',
              rearLidNo: responseJson['rear_lid_no'] ?? '',
              message: message,
              ocrRegNo: ocrRegNo,
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error uploading image: ${response.statusCode}'),
              duration: const Duration(seconds: 2)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Exception caught: $e'),
            duration: const Duration(seconds: 2)),
      );
    }
  }

  Color _getColorFromValue(int value) {
    switch (value) {
      case 1:
        return Colors.white;
      case 2:
        return const Color.fromARGB(255, 255, 240, 101);
      case 3:
        return const Color.fromARGB(255, 126, 240, 130);
      case 4:
        return Colors.black;
      default:
        return Colors.grey;
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
        return 'Unknown';
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
        return 'Unknown Size';
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
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
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
                const SizedBox(height: 10),
                Text(
                  'Color: $colorName',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 30,
                  color: selectedColor,
                ),
                const SizedBox(height: 10),
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
          const SizedBox(height: 20),
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
                      icon:
                          const Icon(Icons.close, color: Colors.red, size: 30),
                      onPressed: () {
                        setState(() {
                          _image = null;
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: GoogleFonts.poppins(fontSize: 18),
                  ),
                  child: Text(
                    'Open Camera',
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          if (_image != null)
            ElevatedButton(
              onPressed: postPlateDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: GoogleFonts.poppins(fontSize: 18),
              ),
              child: Text(
                'Post Details',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

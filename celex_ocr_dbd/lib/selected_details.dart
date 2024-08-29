import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:img_picker/img_picker.dart';

import 'failure_results.dart';
import 'success_result.dart';

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

  Future<void> postPlateDetails() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    // Show the Snackbar
    final snackBar = SnackBar(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Processing...'),
        ],
      ),
      duration: const Duration(
          minutes: 1), // Keep it visible until dismissed manually
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Convert image to base64 string
    String base64Image = base64Encode(await _image!.readAsBytes());

    // Define the API endpoint
    final url = Uri.parse(
        'https://uat-newmmhsrp.celexhsrp.in/hsrp-ocr/img_ocr_res.php'); // Replace with your API URL

    // Create the request body
    final Map<String, dynamic> requestBody = {
      "plate_color": widget.colorValue.toString(),
      "plate_size": widget.sizeValue.toString(),
      "esm_id": "1", // Replace with your actual esm_id if needed
      "attachment": base64Image,
    };
    print("Request body: $requestBody");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      // Dismiss the Snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        // Parse response data
        final responseData = jsonDecode(response.body);
        print("Response data: $responseData");

        // Ensure that each key exists and is not null before using it
        String regNo = responseData['reg_no'] ?? 'Unknown';
        String frontLidNo = responseData['front_lid_no'] ?? 'Unknown';
        String rearLidNo = responseData['rear_lid_no'] ?? 'Unknown';
        String message = responseData['message'] ?? 'Unknown';

        // Check the status and navigate accordingly
        if (responseData['status'] == 1) {
          // Navigate to the ScannedResults screen with API response data
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessResults(
                regNo: regNo,
                frontLidNo: frontLidNo,
                rearLidNo: rearLidNo,
              ),
            ),
          );
        } else {
          // Navigate to the FailedResults screen with API response data
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FailedResults(
                regNo: regNo,
                frontLidNo: frontLidNo,
                rearLidNo: rearLidNo,
                message: message,
              ),
            ),
          );
        }
      } else {
        // Handle error response
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // Dismiss the Snackbar in case of an exception
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      print('Exception caught: $e');
      print('Stack trace: ${e.toString()}');
    }
  }

  Color _getColorFromValue(int value) {
    switch (value) {
      case 1:
        return Colors.white;
      case 2:
        return Color.fromARGB(255, 255, 240, 101);
      case 3:
        return Color.fromARGB(255, 126, 240, 130);
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
          const SizedBox(height: 20),
          if (_image != null)
            ElevatedButton(
              onPressed: postPlateDetails,
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

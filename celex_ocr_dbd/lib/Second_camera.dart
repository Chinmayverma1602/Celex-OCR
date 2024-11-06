import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:img_picker/img_picker.dart';

import 'failure_results.dart';
import 'success_result.dart';

class CameraScreen2 extends StatefulWidget {
  final int colorValue;
  final int sizeValue;

  const CameraScreen2({
    super.key,
    required this.colorValue,
    required this.sizeValue,
  });

  @override
  _CameraScreenState2 createState() => _CameraScreenState2();
}

class _CameraScreenState2 extends State<CameraScreen2> {
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

    // Show the initial Snackbar for processing
    const snackBar = SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Processing...'),
        ],
      ),
      duration:
          Duration(minutes: 1), // Keep it visible until dismissed manually
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Define the API endpoint
    final url = Uri.parse(
        'https://uat-newmmhsrp.celexhsrp.in/hsrp-ocr/img_ocr_response.php');

    // Create a Multipart request
    var request = http.MultipartRequest('POST', url);

    // Add the fields to the request
    request.fields['plate_color'] = widget.colorValue.toString();
    request.fields['plate_size'] = widget.sizeValue.toString();
    request.fields['esm_id'] = "1"; // Replace with your actual esm_id if needed

    // Attach the image file to the request as "attachment"
    request.files.add(await http.MultipartFile.fromPath(
      'attachment',
      _image!.path,
    ));

    try {
      // Send the request
      var response = await request.send();

      // Dismiss the processing Snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        // Convert response to string
        final responseData = await response.stream.bytesToString();
        print("Response data: $responseData");

        if (responseData.isEmpty) {
          print("Error: Response data is empty.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Received empty response from server.'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        try {
          // Attempt to parse JSON
          final responseJson = jsonDecode(responseData);

          // Ensure that each key exists and is not null before using it
          String regNo = responseJson['reg_no'] ?? '';
          String frontLidNo = responseJson['front_lid_no'] ?? '';
          String rearLidNo = responseJson['rear_lid_no'] ?? '';
          String message = responseJson['message'] ?? '';
          String ocrRegNo = responseJson['ocr_reg_no'] ?? '';
          String ocrLidNo = responseJson['ocr_lid_no'] ?? '';

          // Check the status and navigate accordingly
          if (responseJson['status'] == 1) {
            // Navigate to the SuccessResults screen with API response data
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SuccessResults(
                  regNo: regNo,
                  frontLidNo: frontLidNo,
                  rearLidNo: rearLidNo,
                  ocrLidNo: ocrLidNo,
                  ocrRegNo: ocrRegNo,
                ),
              ),
            );
          } else {
            // Navigate to the FailedResults screen with API response data
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FailedResults(
                  regNo: regNo,
                  ocrLidNo: ocrLidNo,
                  frontLidNo: frontLidNo,
                  rearLidNo: rearLidNo,
                  message: message,
                  ocrRegNo: ocrRegNo,
                ),
              ),
            );
          }
        } catch (e) {
          print("Error parsing JSON: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error parsing server response.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Error response body: ${await response.stream.bytesToString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: ${response.statusCode}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Dismiss the Snackbar in case of an exception
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      print('Exception caught: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception caught: $e'),
          duration: const Duration(seconds: 2),
        ),
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
          const SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const BackupScanning()));
          //     },
          //     child: const Text("New Button")),
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
                'Next',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

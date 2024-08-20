import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:celex_ocr_dbd/selected_details.dart'; // Ensure this import is correct for CameraScreen

class HsrpSize extends StatefulWidget {
  final int colorValue; // Color value passed from HsrpColor
  final String colorName; // Color name passed from HsrpColor

  const HsrpSize({
    super.key,
    required this.colorValue,
    required this.colorName,
  });

  @override
  State<HsrpSize> createState() => _HsrpSizeState();
}

class _HsrpSizeState extends State<HsrpSize> {
  int? selectedSizeValue;

  void _openCamera() {
    // Ensure selectedSizeValue is not null before navigating
    if (selectedSizeValue != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CameraScreen(
            colorValue: widget.colorValue,
            sizeValue: selectedSizeValue!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HSRP Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display selected color and its name
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Selected Color: ',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  /*  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(widget.colorValue),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ), */
                  //   SizedBox(width: 10),
                  Text(
                    widget.colorName,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Container for size selection
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: 280,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: .1),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Select HSRP size',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSizeValue = 2; // 285 x 45
                            });
                            _openCamera();
                          },
                          child: Text(
                            "285 x 45",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSizeValue = 1; // 200 x 100
                            });
                            _openCamera();
                          },
                          child: Text(
                            "200 x 100",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSizeValue = 3; // 500 x 120
                            });
                            _openCamera();
                          },
                          child: Text(
                            "500 x 120",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSizeValue = 4; // 340 x 200
                            });
                            _openCamera();
                          },
                          child: Text(
                            "340 x 200",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

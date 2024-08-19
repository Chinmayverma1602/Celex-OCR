import 'package:celex_ocr_dbd/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedDetails extends StatefulWidget {
  const ScannedDetails({super.key});

  @override
  State<ScannedDetails> createState() => _ScannedDetailsState();
}

class _ScannedDetailsState extends State<ScannedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanned Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 188, 233, 255),
              ),
              height: 200,
              width: 300,
              child: Stack(
                children: [
                  Positioned(
                    left: 12,
                    top: 10,
                    child: Text(
                      'OCR Details',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 10,
                    child: Text(
                      'DBD Details',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 40, // Adjust top position to fit below "OCR Details"
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          height: 40,
                          width: 130,
                          child: Text(
                            'Data',
                            style: GoogleFonts.poppins(),
                          ),
                          // color: Colors.grey.shade200,
                        ),
                        SizedBox(height: 25), // Spacing between containers
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          height: 40,
                          width: 130,
                          child: Text(
                            'Data',
                            style: GoogleFonts.poppins(),
                          ),
                          // color: Colors.grey.shade200,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 40, // Adjust top position to fit below "DBD Details"
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          height: 40,
                          width: 130,
                          child: Text(
                            'Data',
                            style: GoogleFonts.poppins(),
                          ),
                          // color: Colors.grey.shade200,
                        ),
                        SizedBox(height: 25), // Spacing between containers
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          height: 40,
                          width: 130,
                          child: Text(
                            'Data',
                            style: GoogleFonts.poppins(),
                          ),
                          // color: Colors.grey.shade200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Background color for Pass button
                ),
                child: Text(
                  "Pass",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red, // Background color for Fail button
                ),
                child: Text(
                  "Fail",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

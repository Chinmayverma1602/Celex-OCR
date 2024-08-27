import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:celex_ocr_dbd/HSRP_size.dart'; // Ensure this import is correct for HsrpSize

class HsrpColor extends StatefulWidget {
  const HsrpColor({super.key});

  @override
  State<HsrpColor> createState() => _HsrpColorState();
}

class _HsrpColorState extends State<HsrpColor> {
  void _navigateToNextScreen(int colorValue, String colorName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HsrpSize(
          colorValue: colorValue,
          colorName: colorName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HSRP Color',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: 280,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.black, width: .1), // Black border color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Select HSRP color',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextScreen(1, "White");
                          },
                          child: Text(
                            "White",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextScreen(2, "Yellow"); // Yellow
                          },
                          child: Text(
                            "Yellow",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 240, 101),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextScreen(3, "Green"); // Green
                          },
                          child: Text(
                            "Green",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 126, 240, 130),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextScreen(4, "Black"); // Black
                          },
                          child: Text(
                            "Black",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:celex_ocr_dbd/failed_results.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedResults extends StatefulWidget {
  const ScannedResults({super.key});

  @override
  State<ScannedResults> createState() => _ScannedResultsState();
}

class _ScannedResultsState extends State<ScannedResults> {
  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Scanned Results",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  width: screenWidth * 0.8, // 80% of screen width
                  height: screenHeight * 0.2, // 20% of screen height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              const        SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Success",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
               const  SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Registration No. & LID No. matched\n      successfully..",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
         const       SizedBox(height: 15), // Space between the containers
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 197, 226, 250),
                  ),
                  width: screenWidth * 0.8, // 80% of screen width
                  height: screenHeight * 0.3, // 20% of screen height
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 25),
                    child: Column(
                      children: [
                        Text(
                          "DBD Details",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                const        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Registration No. :",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                    const        SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: screenWidth * 0.35,
                              height: screenHeight * 00.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100),
                            )
                          ],
                        ),
                  const      SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Front LID No : ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                      const      SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: screenWidth * 0.35,
                              height: screenHeight * 00.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100),
                            )
                          ],
                        ),
                    const    SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rear LID No. :",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                      const      SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: screenWidth * 0.35,
                              height: screenHeight * 00.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          const      SizedBox(height: 10), // Space between the containers
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 197, 226, 250),
                  ),
                  width: screenWidth * 0.8, // 80% of screen width
                  height: screenHeight * 0.24, // 20% of screen height
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 25),
                    child: Column(
                      children: [
                        Text(
                          "OCR Details",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                  const      SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Front LID No : ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                    const        SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: screenWidth * 0.35,
                              height: screenHeight * 00.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100),
                            )
                          ],
                        ),
                  const      SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rear LID No. :",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                    const        SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: screenWidth * 0.35,
                              height: screenHeight * 00.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FailedResults()));
          },
          child: Text(
            "Next",
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 197, 226, 250),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: GoogleFonts.poppins(fontSize: 18),
          ),
        ));
  }
}

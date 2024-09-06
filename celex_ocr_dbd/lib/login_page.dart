import 'dart:convert'; // For encoding and decoding JSON
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg for handling SVG files
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:celex_ocr_dbd/HSRP_color.dart'; // Import your HsrpColor page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> _saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Define the URL and the body for the API request
    const url = 'https://uat-newmmhsrp.celexhsrp.in/hsrp-ocr/login_check.php';
    final body = jsonEncode({
      'user_id': username,
      'password': password,
    });

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Parse the response
      final responseBody = jsonDecode(response.body);

      // Check the status and handle the response
      if (response.statusCode == 200) {
        if (responseBody['status'] == 1) {
          // Save credentials if login is successful
          await _saveCredentials(username, password);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HsrpColor()),
          );
        } else {
          // Show error message if login fails
          _showErrorDialog(responseBody['message']);
        }
      } else {
        // Show error message for HTTP errors
        _showErrorDialog('Failed to connect to the server.');
      }
    } catch (e) {
      // Handle exceptions
      _showErrorDialog('An error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SVG Image just above the Login text
                SvgPicture.asset(
                  "lib/assets/login.svg", // Update path as needed
                  height: 200.0,
                  //  color: Colors.amber, // Adjust height as needed
                ),
                const SizedBox(height: 25),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // Container with background color and border radius for the username field
                Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[200], // Background color inside the TextFormField
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      labelText: 'Login ID',
                      labelStyle: GoogleFonts.poppins(), // Label style
                      border: InputBorder.none, // Remove default border
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 25),
                // Container with background color and border radius for the password field
                Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[200], // Background color inside the TextFormField
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(), // Label style
                      border: InputBorder.none, // Remove default border
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    backgroundColor: Color.fromARGB(255, 233, 118, 143),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

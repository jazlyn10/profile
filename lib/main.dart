import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "John Doe"; // Default name
  String username = "johndoe";
  String email = "johndoe@example.com";
  String contactNumber = "+91 123-4567";
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row( // Add Row for back icon and profile text
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle back button action here
                  },
                ),
                Text(
                  "             Edit Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                _pickImage(); // Call function to pick an image.
              },
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: _image != null
                    ? ClipOval(
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showNameInputDialog("name"); // Call function to show name input dialog.
              },
              child: Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(height: 30, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.person, size: 17),
                  SizedBox(width: 20),
                  Text(
                    "Username:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _showNameInputDialog("username"); // Call function to show username input dialog.
                    },
                    child: Text(
                      username,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 30, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.email, size: 17),
                  SizedBox(width: 20),
                  Text(
                    "Email:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _showNameInputDialog("email"); // Call function to show email input dialog.
                    },
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 30, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.phone, size: 17),
                  SizedBox(width: 20),
                  Text(
                    "Contact Number:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _showNameInputDialog("contactNumber"); // Call function to show contact number input dialog.
                    },
                    child: Text(
                      contactNumber,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the name input dialog.
  void _showNameInputDialog(String inputType) {
    String title = inputType == "name"
        ? "Edit Name"
        : inputType == "username"
        ? "Edit Username"
        : inputType == "email"
        ? "Edit Email"
        : "Edit Contact Number";
    String currentValue = inputType == "name"
        ? name
        : inputType == "username"
        ? username
        : inputType == "email"
        ? email
        : contactNumber;

    showDialog(
      context: context,
      builder: (context) {
        String newValue = currentValue;
        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: (value) {
              newValue = value;
            },
            decoration: InputDecoration(hintText: 'Enter $inputType'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  if (inputType == "name") {
                    name = newValue;
                  } else if (inputType == "username") {
                    username = newValue;
                  } else if (inputType == "email") {
                    email = newValue;
                  } else if (inputType == "contactNumber") {
                    contactNumber = newValue;
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to pick an image from the gallery or camera.
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

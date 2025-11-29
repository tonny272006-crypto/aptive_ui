import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

// --- IMAGE SAVER SCREEN ---

class ImageSaverScreen extends StatefulWidget {
  const ImageSaverScreen({super.key});

  @override
  State<ImageSaverScreen> createState() => _ImageSaverScreenState();
}

class _ImageSaverScreenState extends State<ImageSaverScreen> {
  // Controllers and State
  final TextEditingController _folderController = TextEditingController(
    text: 'MySavedImages',
  );
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  String _statusMessage = 'Select an image and enter a folder name.';

  // --- HANDLERS ---

  /// 1. Pick Image from Gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
          // Extract just the file name for display
          final fileName = image.path.split('/').last;
          _statusMessage = 'Image selected: $fileName';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error picking image: $e';
      });
    }
  }

  /// 2. Request Storage Permission
  Future<bool> _requestPermission() async {
    // We request the appropriate permission (storage/media library)
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// 3. Save Image Logic
  Future<void> _saveImage() async {
    if (_selectedImage == null) {
      setState(() => _statusMessage = 'Please select an image first.');
      return;
    }

    final folderName = _folderController.text.trim();
    if (folderName.isEmpty) {
      setState(() => _statusMessage = 'Please enter a folder name.');
      return;
    }

    // Check permissions
    final hasPermission = await _requestPermission();
    if (!hasPermission) {
      setState(
        () => _statusMessage = 'Storage permission denied. Cannot save file.',
      );
      return;
    }

    setState(() => _statusMessage = 'Saving...');

    try {
      // Get the application documents directory (sandboxed private storage)
      // This ensures we have write access without needing complex public storage logic.
      final directory = await getApplicationDocumentsDirectory();

      // Create the path for the new folder
      final folderPath = '${directory.path}/$folderName';
      final folder = Directory(folderPath);

      // Create the folder if it doesn't exist
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      // Create the new file path for the image
      final fileName = _selectedImage!.name;
      final newFilePath = '$folderPath/$fileName';

      // Copy the selected file to the new location
      final File savedFile = await File(_selectedImage!.path).copy(newFilePath);

      setState(() {
        _statusMessage = 'Image successfully saved to folder "$folderName"';
        _selectedImage = null; // Clear selected image
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to save image: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Image Folder Saver'),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Folder Name Input
            TextField(
              controller: _folderController,
              decoration: InputDecoration(
                labelText: 'Folder Name',
                hintText: 'e.g., Summer Trip, Work Docs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.folder),
              ),
            ),
            const SizedBox(height: 20),

            // Pick Image Button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('1. Pick Image from Gallery'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Image Preview/Status
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: _selectedImage != null
                  ? Image.file(
                      File(_selectedImage!.path),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text("Error loading image")),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _statusMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 30),

            // Save Image Button
            ElevatedButton.icon(
              onPressed: _selectedImage != null ? _saveImage : null,
              icon: const Icon(Icons.save),
              label: const Text('2. Save Image to Folder'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

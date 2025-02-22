import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditCommunityScreen extends StatefulWidget {
  final String name;
  const EditCommunityScreen({
    super.key,
    required this.name,
  });

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;
  Uint8List? bannerWebFile;
  Uint8List? profileWebFile;

  // Mock community data
  final Map<String, dynamic> mockCommunity = {
    'name': 'flutter',
    'banner': 'https://via.placeholder.com/400x150', // Placeholder banner image
    'avatar': 'https://via.placeholder.com/100', // Placeholder avatar image
  };

  // Mock theme data (since themeNotifierProvider is removed)
  final mockTheme = {
    'backgroundColor': Colors.grey[900],
    'textColor': Colors.white,
  };

  // Simulate image picking (replace with your actual image picker logic if needed)
  Future<void> selectBannerImage() async {
    // Simulate picking an image (for demo purposes, we'll just set a placeholder)
    setState(() {
      if (kIsWeb) {
        bannerWebFile = Uint8List(0); // Placeholder for web
      } else {
        bannerFile = File(''); // Placeholder for mobile (empty file path)
      }
    });
    print('Banner image selected');
  }

  Future<void> selectProfileImage() async {
    // Simulate picking an image
    setState(() {
      if (kIsWeb) {
        profileWebFile = Uint8List(0); // Placeholder for web
      } else {
        profileFile = File(''); // Placeholder for mobile (empty file path)
      }
    });
    print('Profile image selected');
  }

  void save() {
    // Simulate saving changes (replace with your logic)
    print('Saving community edits for ${widget.name}');
    print('Banner: ${bannerFile ?? bannerWebFile}');
    print('Profile: ${profileFile ?? profileWebFile}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Community updated!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final community = mockCommunity;
    final currentTheme = mockTheme;
    const bool isLoading =
        false; // Hardcoded for simplicity; add logic if needed

    return Scaffold(
      backgroundColor: currentTheme['backgroundColor'],
      appBar: AppBar(
        title: const Text('Edit Community'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Simple loading indicator
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            color: currentTheme['textColor']!,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: bannerWebFile != null
                                  ? Image.memory(bannerWebFile!)
                                  : bannerFile != null
                                      ? Image.file(bannerFile!)
                                      : community['banner'].isEmpty
                                          ? const Center(
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40,
                                              ),
                                            )
                                          : Image.network(community['banner']),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileWebFile != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(profileWebFile!),
                                    radius: 32,
                                  )
                                : profileFile != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            FileImage(profileFile!),
                                        radius: 32,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(community['avatar']),
                                        radius: 32,
                                      ),
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
}

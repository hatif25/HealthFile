import 'package:flutter/material.dart';

class UploadDocumentsPage extends StatelessWidget {
  final PageController pageController;

  UploadDocumentsPage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            pageController.jumpToPage(0); // Navigate back to HomePage
          },
        ),
        title: Text('Upload Your Documents'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a document to upload:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUploadItem(context, Icons.article, 'Report', () {
                  // Handle Report upload
                }),
                _buildUploadItem(context, Icons.description, 'Prescription', () {
                  // Handle Prescription upload
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF6C5DD4),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
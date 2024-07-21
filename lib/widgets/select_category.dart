import 'package:flutter/material.dart';

class CategorySelectionPage extends StatefulWidget {
  final Function(int) onCategorySelected;

  const CategorySelectionPage({required this.onCategorySelected, Key? key}) : super(key: key);

  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a category for your document:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCategoryItem('Blood Test', 1),
                  _buildCategoryItem('Hydrology', 2),
                  // Add more categories as needed
                ],
              ),
            ),
            SizedBox(height: 20),
            if (selectedCategoryId != null)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    widget.onCategorySelected(selectedCategoryId!);
                  },
                  child: Text(
                    'Proceed to Upload',
                    style: TextStyle(fontSize: 18,color: Colors.white),

                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
Widget _buildCategoryItem(String label, int categoryId) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4), // Reduced vertical margin
    elevation: 3, // Reduced elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Slightly smaller border radius
    ),
    color: selectedCategoryId == categoryId
        ? Colors.deepPurple // Card color when selected
        : Colors.white, // Card color when not selected
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16, // Slightly smaller font size
          fontWeight: FontWeight.w500,
          color: selectedCategoryId == categoryId
              ? Colors.white // Text color when selected
              : Colors.black, // Text color when not selected
        ),
      ),
      onTap: () {
        setState(() {
          selectedCategoryId = categoryId;
        });
      },
    ),
  );
}
}
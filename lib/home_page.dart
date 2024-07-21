// home_page.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_manager/appointments_page.dart';
import 'package:health_manager/more_page.dart';
import 'package:health_manager/prescriptions_page.dart';
import 'package:health_manager/reports_page.dart';
import 'package:health_manager/time_slots_page.dart';
import 'package:health_manager/upload_docs_page.dart';
import 'package:health_manager/widgets/health_file_card.dart';
import 'package:health_manager/widgets/select_category.dart'; // Correct import

class BottomNavItem {
  String? iconPath;
  IconData? icon;
  String label;

  BottomNavItem({this.iconPath, this.icon, required this.label});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = -1;
  final PageController _pageController = PageController(initialPage: 0);

  List<BottomNavItem> navItems = [
    BottomNavItem(icon: Icons.article_outlined, label: 'Report'),
    BottomNavItem(icon: Icons.calendar_today, label: 'Appointment'),
    BottomNavItem(icon: Icons.description, label: 'Prescription'),
    BottomNavItem(icon: Icons.more_horiz, label: 'More'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index - 1;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.animateToPage(
      selectedIndex + 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // Handle the selected PDF file
      final path = result.files.single.path;
      print('Selected file: $path');
      // You can implement further actions here, like uploading the file
    } else {
      // User canceled the picker
      print('No file selected');
    }
  }

  void _showUploadOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.article, color: Colors.deepPurple),
                title: Text('Upload Report'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _navigateToCategorySelectionPage(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.description, color: Colors.deepPurple),
                title: Text('Upload Prescription'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _navigateToUploadDocumentsPage(context, null);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToCategorySelectionPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategorySelectionPage(
          onCategorySelected: (categoryId) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadDocumentsPage(
                  selectedCategoryId: categoryId, // Pass as int
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToUploadDocumentsPage(BuildContext context, int? categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadDocumentsPage(
          selectedCategoryId: categoryId ?? -1, // Provide a default value if null
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.05,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Pooja',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Welcome to Another Page',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.029,
                                color: Color(0xFF999CA5),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.notifications,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  HealthFileCard(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Text(
                    'Doctors Connected with You',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return DoctorListItem();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ReportsPage(pageController: _pageController),
          AppointmentsPage(pageController: _pageController),
          PrescriptionsPage(pageController: _pageController),
          MorePage(pageController: _pageController),
        ],
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(item.icon, size: MediaQuery.of(context).size.width * 0.07),
                    color: _currentIndex == navItems.indexOf(item)
                        ? Color(0xFF6C5DD4)
                        : Colors.grey,
                    onPressed: () {
                      _onItemTapped(navItems.indexOf(item));
                    },
                  ),
                  Flexible(
                    child: Text(
                      item.label,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.02, fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Color(0xFF6C5DD4),
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {
              _showUploadOptionsModal(context);
            },
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

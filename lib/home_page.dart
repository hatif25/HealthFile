import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_manager/appointments_page.dart';
import 'package:health_manager/more_page.dart';
import 'package:health_manager/prescriptions_page.dart';
import 'package:health_manager/reports_page.dart';
import 'package:health_manager/widgets/doctor_list_item.dart';
import 'package:health_manager/widgets/health_file_card.dart';

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

  void _showUploadModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Your Documents',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildUploadItem(context, Icons.article, 'Report', () {
                    _showUploadReportModal(context);
                  }),
                  _buildUploadItem(context, Icons.description, 'Prescription', () {
                    _showUploadPrescriptionModal(context);
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUploadReportModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.article, color: Colors.deepPurple),
              SizedBox(width: 8),
              Text('Upload Report'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pickFile();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Browse'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showUploadPrescriptionModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.description, color: Colors.deepPurple),
              SizedBox(width: 8),
              Text('Upload Prescription'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pickFile();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Browse'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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
              _showUploadModal(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
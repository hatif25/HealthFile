import 'package:flutter/material.dart';
import 'package:health_manager/profile_page.dart';

class MorePage extends StatelessWidget {
  final PageController pageController;

  MorePage({required this.pageController});

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
        title: Text(
          'More',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 28),
          _buildListItem(context, Icons.person, 'Profile'),
          _buildListItem(context, Icons.history, 'Medical History'),
          _buildListItem(context, Icons.settings, 'Settings'),
          _buildListItem(context, Icons.help, 'Helpdesk'),
          _buildListItem(context, Icons.logout, 'Log Out'),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF6C5DD4)),
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      onTap: () {
        if (title == 'Log Out') {
          // Handle logout functionality here
        } else {
          // Push respective page based on the title
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            switch (title) {
              case 'Profile':
                return ProfilePage(); 
              case 'Medical History':
                // return MedicalHistoryPage(); // Replace with actual MedicalHistoryPage widget
              case 'Settings':
                // return SettingsPage(); // Replace with actual SettingsPage widget
              case 'Helpdesk':
                // return HelpdeskPage(); // Replace with actual HelpdeskPage widget
              default:
                return MorePage(pageController: pageController); // Fallback
            }
          }));
        }
      },
      )
    );
  }
}

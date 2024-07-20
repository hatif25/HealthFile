import 'package:flutter/material.dart';

class PrescriptionsPage extends StatelessWidget {
  final PageController pageController;

  PrescriptionsPage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pageController.jumpToPage(0); // Navigate back to HomePage
        return false; // Prevent default pop behavior
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              pageController.jumpToPage(0); // Navigate back to HomePage
            },
          ),
          title: Text(
            'My Prescriptions',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implement filter logic
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildPrescriptionCategory(context, 'Recent Prescriptions', [
                  {'title': 'Prescription for Hypertension', 'date': '15th Jul 2024', 'isVisible': true},
                  {'title': 'Antibiotics for Infection', 'date': '20th Jul 2024', 'isVisible': false},
                  {'title': 'Diabetes Medication', 'date': '22nd Jul 2024', 'isVisible': true},
                ]),
                SizedBox(height: 20),
                _buildPrescriptionCategory(context, 'Older Prescriptions', [
                  {'title': 'Allergy Medication', 'date': '10th Jun 2024', 'isVisible': true},
                  {'title': 'Cholesterol Medication', 'date': '15th May 2024', 'isVisible': false},
                  {'title': 'Pain Relief Medication', 'date': '25th Apr 2024', 'isVisible': true},
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrescriptionCategory(BuildContext context, String category, List<Map<String, dynamic>> prescriptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextStyle(
            color: Color(0xFF6C5DD4),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: prescriptions.length,
          itemBuilder: (context, index) {
            return _buildPrescriptionListItem(
              context,
              icon: Icons.medical_services,
              title: prescriptions[index]['title'],
              date: prescriptions[index]['date'],
              isVisible: prescriptions[index]['isVisible'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPrescriptionListItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String date,
      required bool isVisible}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(date),
      trailing: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        onPressed: () {
          // Toggle visibility logic
        },
      ),
    );
  }
}

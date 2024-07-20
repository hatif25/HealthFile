import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  final PageController pageController;

  ReportsPage({required this.pageController});

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
            'My Reports',
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
                    _buildReportCategory(context, 'Blood', [
                  {'title': 'Thyroid Test', 'date': '17th Aug 2024', 'isVisible': true},
                  {'title': 'Blood Pressure Checkup', 'date': '20th Aug 2024', 'isVisible': false},
                  {'title': 'Hemoglobin Test', 'date': '22nd Aug 2024', 'isVisible': true},
                  {'title': 'Cholesterol Screening', 'date': '25th Aug 2024', 'isVisible': false},
                  {'title': 'Glucose Test', 'date': '28th Aug 2024', 'isVisible': true},
                  {'title': 'Complete Blood Count', 'date': '1st Sep 2024', 'isVisible': false},
                  {'title': 'Iron Levels Check', 'date': '5th Sep 2024', 'isVisible': true},
                ]),
                SizedBox(height: 20),
                _buildReportCategory(context, 'Hydrology', [
                  {'title': 'Water Quality Test', 'date': '10th Sep 2024', 'isVisible': true},
                  {'title': 'Groundwater Analysis', 'date': '12th Sep 2024', 'isVisible': false},
                  {'title': 'Water Usage Report', 'date': '15th Sep 2024', 'isVisible': true},
                  {'title': 'Flood Risk Assessment', 'date': '18th Sep 2024', 'isVisible': false},
                  {'title': 'Hydrological Survey', 'date': '20th Sep 2024', 'isVisible': true},
                  {'title': 'Rainwater Harvesting Audit', 'date': '22nd Sep 2024', 'isVisible': false},
                  {'title': 'Watershed Management Plan', 'date': '25th Sep 2024', 'isVisible': true},
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportCategory(BuildContext context, String category, List<Map<String, dynamic>> reports) {
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
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return _buildReportListItem(
              context,
              icon: Icons.description,
              title: reports[index]['title'],
              date: reports[index]['date'],
              isVisible: reports[index]['isVisible'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildReportListItem(BuildContext context,
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

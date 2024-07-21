import 'package:flutter/material.dart';
import 'package:health_manager/model/report_modal.dart'; // Ensure this is the correct path
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportsPage extends StatefulWidget {
  final PageController pageController;

  ReportsPage({required this.pageController});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late Future<List<Report>> futureReports;
  final ReportService reportService = ReportService();
  List<Report> _reports = []; // Maintain the list of reports locally

  @override
  void initState() {
    super.initState();
    futureReports = reportService.fetchReports();
    futureReports.then((reports) {
      setState(() {
        _reports = reports;
      });
    });
  }

  void _toggleVisibility(int reportId) {
    setState(() {
      _reports = _reports.map((report) {
        if (report.id == reportId) {
          return Report(
            id: report.id,
            title: report.title,
            reportCreatedDate: report.reportCreatedDate,
            isVisible: !report.isVisible,
            createdAt: report.createdAt,
            fileUrl: report.fileUrl,
            
          );
        }
        return report;
      }).toList();
    });
    // Here you can also implement the API call to update the visibility status on the backend
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.pageController.jumpToPage(0); // Navigate back to HomePage
        return false; // Prevent default pop behavior
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              widget.pageController.jumpToPage(0); // Navigate back to HomePage
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
          child: FutureBuilder<List<Report>>(
            future: futureReports,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No reports found'));
              } else {
                List<Report> reports = snapshot.data!;
                // Store reports locally
                _reports = reports;
                return SingleChildScrollView(
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
                      _buildReportCategory(context, 'Reports', _reports),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReportCategory(BuildContext context, String category, List<Report> reports) {
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
              title: reports[index].title,
              date: reports[index].reportCreatedDate,
              isVisible: reports[index].isVisible,
              reportId: reports[index].id,
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
      required bool isVisible,
      required int reportId}) {
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
          _toggleVisibility(reportId);
        },
      ),
    );
  }
}



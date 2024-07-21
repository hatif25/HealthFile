import 'dart:convert';
import 'package:http/http.dart' as http;
 // Import the Report model




class Report {
  final int id;
  final String title;
  final String reportCreatedDate;
  final bool isVisible;
  final String createdAt;
  final String fileUrl;

  Report({
    required this.id,
    required this.title,
    required this.reportCreatedDate,
    required this.isVisible,
    required this.createdAt,
    required this.fileUrl,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      reportCreatedDate: json['report_created_date'],
      isVisible: json['isVisible'],
      createdAt: json['created_at'],
      fileUrl: json['file_url'],
    );
  }
}


class ReportService {
  final String baseUrl = "http://192.168.54.173:8000/api/reports/?skip=0&limit=10";

  Future<List<Report>> fetchReports() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Report> reports = body.map((dynamic item) => Report.fromJson(item)).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
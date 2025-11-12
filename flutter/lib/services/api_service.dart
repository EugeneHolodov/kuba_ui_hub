import 'dart:convert';
import 'package:http/http.dart' as http;

class Reviewer {
  final int id;
  final String name;

  Reviewer({required this.id, required this.name});

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(id: json['id'] as int, name: json['name'] as String);
  }
}

class ApiService {
  // Backend URL configuration
  // For web: uses environment variable or defaults to production URL
  // For iOS simulator: http://localhost:3000
  // For Android emulator: http://10.0.2.2:3000
  // For physical device: http://YOUR_COMPUTER_IP:3000 (e.g., http://192.168.1.100:3000)
  // To find your IP: macOS/Linux: ifconfig | grep "inet " | grep -v 127.0.0.1
  //                   Windows: ipconfig (look for IPv4 Address)

  // Get base URL from environment or use default
  // In web builds, you can set this via window.location or environment variables
  static String get baseUrl {
    // For web, try to get from window location or use production URL
    // Replace 'YOUR_BACKEND_URL' with your actual deployed backend URL
    // Example: https://your-backend.onrender.com
    const String productionUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:3000',
    );

    // In web context, you might want to use relative URLs or detect the host
    // For now, we'll use the environment variable or default
    return productionUrl;
  }

  // Get all reviewers
  static Future<List<Reviewer>> getReviewers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/reviewers'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> reviewersJson = data['reviewers'];
        return reviewersJson.map((json) => Reviewer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load reviewers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching reviewers: $e');
    }
  }

  // Submit a review
  static Future<void> submitReview({
    required int reviewerId,
    required String widgetName,
    required String comment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/reviews'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reviewer_id': reviewerId,
          'widget_name': widgetName,
          'comment': comment,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to submit review: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error submitting review: $e');
    }
  }
}

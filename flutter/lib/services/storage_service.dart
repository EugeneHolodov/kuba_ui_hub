import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _reviewerIdKey = 'reviewer_id';
  static const String _reviewerNameKey = 'reviewer_name';

  // Save reviewer ID and name
  static Future<void> saveReviewer(int reviewerId, String reviewerName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_reviewerIdKey, reviewerId);
    await prefs.setString(_reviewerNameKey, reviewerName);
  }

  // Get reviewer ID
  static Future<int?> getReviewerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_reviewerIdKey);
  }

  // Get reviewer name
  static Future<String?> getReviewerName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_reviewerNameKey);
  }

  // Check if reviewer is already selected
  static Future<bool> hasReviewer() async {
    final reviewerId = await getReviewerId();
    return reviewerId != null;
  }

  // Clear reviewer data (for logout/reset)
  static Future<void> clearReviewer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_reviewerIdKey);
    await prefs.remove(_reviewerNameKey);
  }
}

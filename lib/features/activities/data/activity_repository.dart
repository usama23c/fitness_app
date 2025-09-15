import 'package:flutter/foundation.dart';
import 'package:fitness_app/features/activities/domain/activity.dart';

class ActivityRepository extends ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => List.unmodifiable(_activities);

  // Get activities sorted by date (newest first)
  List<Activity> get sortedActivities {
    _activities.sort((a, b) => b.date.compareTo(a.date));
    return List.unmodifiable(_activities);
  }

  // Filter activities by type
  List<Activity> activitiesByType(ActivityType type) {
    return List.unmodifiable(
        _activities.where((activity) => activity.type == type).toList());
  }

  // Get activities for a specific date
  List<Activity> activitiesForDate(DateTime date) {
    return List.unmodifiable(_activities
        .where((activity) =>
            activity.date.year == date.year &&
            activity.date.month == date.month &&
            activity.date.day == date.day)
        .toList());
  }

  // Get total duration for all activities
  int get totalDuration {
    return _activities.fold(0, (sum, activity) => sum + activity.duration);
  }

  // Get total calories burned
  int get totalCalories {
    return _activities.fold(0, (sum, activity) => sum + activity.calories);
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(String id, Activity updatedActivity) {
    final index = _activities.indexWhere((activity) => activity.id == id);
    if (index != -1) {
      _activities[index] = updatedActivity;
      notifyListeners();
    }
  }

  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
    notifyListeners();
  }

  void clearAllActivities() {
    _activities.clear();
    notifyListeners();
  }

  // Get activities in a date range
  List<Activity> activitiesInDateRange(DateTime start, DateTime end) {
    return List.unmodifiable(_activities
        .where((activity) =>
            activity.date.isAfter(start) && activity.date.isBefore(end))
        .toList());
  }

  // Get most frequent activity type
  ActivityType? get mostFrequentActivityType {
    if (_activities.isEmpty) return null;

    final typeCounts = <ActivityType, int>{};
    for (var activity in _activities) {
      typeCounts[activity.type] = (typeCounts[activity.type] ?? 0) + 1;
    }

    return typeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}

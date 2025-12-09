import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/kuba_search_bar_bottom.dart';
import '../models/activity_item.dart';
import '../data/activity_data.dart';

class NavBarTabsSegmentedButtonsPage extends StatefulWidget {
  const NavBarTabsSegmentedButtonsPage({super.key});

  @override
  State<NavBarTabsSegmentedButtonsPage> createState() =>
      _NavBarTabsSegmentedButtonsPageState();
}

class _NavBarTabsSegmentedButtonsPageState
    extends State<NavBarTabsSegmentedButtonsPage> {
  int _selectedIndex = 0;
  String? _searchQuery;

  // Sample activity data
  List<ActivityItem> get _allActivities => getSampleActivities();

  // Get activities for the selected tab
  List<ActivityItem> _getActivitiesForTab(int tabIndex) {
    String status;
    switch (tabIndex) {
      case 0:
        status = 'new';
        break;
      case 1:
        status = 'open';
        break;
      case 2:
        status = 'done';
        break;
      case 3:
        status = 'rejected';
        break;
      default:
        status = 'new';
    }

    var activities = _allActivities
        .where((activity) => activity.status == status)
        .toList();

    // Apply search filter if query exists
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      activities = activities.where((activity) {
        return activity.title.toLowerCase().contains(query) ||
            activity.description.toLowerCase().contains(query) ||
            (activity.assignee?.toLowerCase().contains(query) ?? false) ||
            (activity.priority?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return activities;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'open':
        return Colors.orange;
      case 'done':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentActivities = _getActivitiesForTab(_selectedIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nav Bar Tabs - Segmented Buttons'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // SegmentedButtons at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: [
                ButtonSegment<int>(
                  value: 0,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.new_releases, size: 20),
                        const SizedBox(height: 4),
                        const Text('New'),
                      ],
                    ),
                  ),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_open, size: 20),
                        const SizedBox(height: 4),
                        const Text('Open'),
                      ],
                    ),
                  ),
                ),
                ButtonSegment<int>(
                  value: 2,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 20),
                        const SizedBox(height: 4),
                        const Text('Done'),
                      ],
                    ),
                  ),
                ),
                ButtonSegment<int>(
                  value: 3,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel, size: 20),
                        const SizedBox(height: 4),
                        const Text('Rejected'),
                      ],
                    ),
                  ),
                ),
              ],
              selected: {_selectedIndex},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  _selectedIndex = newSelection.first;
                });
              },
              showSelectedIcon: false,
            ),
          ),
          // List content
          Expanded(
            child: currentActivities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No activities found',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This tab is empty',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: currentActivities.length,
                    itemBuilder: (context, index) {
                      final activity = currentActivities[index];
                      final statusColor = _getStatusColor(activity.status);
                      final priorityColor = _getPriorityColor(
                        activity.priority,
                      );

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selected: ${activity.title}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        activity.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: statusColor.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        activity.status.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: statusColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  activity.description,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    if (activity.assignee != null) ...[
                                      Icon(
                                        Icons.person_outline,
                                        size: 16,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        activity.assignee!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                      const SizedBox(width: 16),
                                    ],
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateFormat(
                                        'MMM dd, yyyy',
                                      ).format(activity.createdAt),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                    if (activity.priority != null) ...[
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.flag,
                                              size: 12,
                                              color: priorityColor,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              activity.priority!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: priorityColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: KubaSearchBarBottom(
        value: _searchQuery,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        isPrimary: true,
        hintText: 'Search activities...',
        onSearch: () {
          FocusScope.of(context).unfocus();
        },
        filterOptions: [
          SearchBarFilterOption(
            icon: Icons.filter_list,
            label: 'Filter by Status',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Status selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.person,
            label: 'Filter by Assignee',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Assignee selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.flag,
            label: 'Filter by Priority',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Priority selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.calendar_today,
            label: 'Filter by Date',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Date selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
        actionButtonIcon: Icons.add,
        onActionButtonPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new activity'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}

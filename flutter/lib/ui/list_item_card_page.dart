import 'package:flutter/material.dart';
import '../widgets/kuba_list_item_card.dart';
import '../widgets/review_input.dart';

class ListItemCardPage extends StatefulWidget {
  const ListItemCardPage({super.key});

  @override
  State<ListItemCardPage> createState() => _ListItemCardPageState();
}

class _ListItemCardPageState extends State<ListItemCardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('List Item Card'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card 1: Basic Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Card with subtitle, leading icon, header tags, and trailing icons. Swipe right to delete.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Task Item',
              subtitle: 'Complete the project documentation',
              leadingIcon: Icons.task_alt,
              leadingIconColor: theme.colorScheme.primary,
              trailingIcons: [
                TrailingIcon(
                  icon: Icons.edit,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit pressed')),
                    );
                  },
                  tooltip: 'Edit',
                ),
              ],
              rightSwipeAction: SwipeAction(
                label: 'Delete',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item deleted'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Card 1 tapped')));
              },
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Card 2: Image & Status Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Card with leading image, top-right badges, bottom row items, and date tag. Swipe left to archive.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Event Item',
              subtitle: 'Team meeting scheduled for next week',
              leadingImage: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.event,
                  color: theme.colorScheme.onSecondaryContainer,
                  size: 32,
                ),
              ),
              topRightItems: [
                TopRightItem(
                  label: 'New',
                  icon: Icons.star,
                  color: theme.colorScheme.primary,
                ),
                TopRightItem(label: 'Hot', color: Colors.orange),
              ],
              bottomRowItems: [
                BottomRowItem(
                  label: 'Status',
                  value: 'Scheduled',
                  valueColor: Colors.green,
                ),
                BottomRowItem(
                  label: 'Priority',
                  value: 'Medium',
                  valueColor: theme.colorScheme.secondary,
                ),
                BottomRowItem(label: 'ID', value: '#EV-123'),
              ],
              leftSwipeAction: SwipeAction(
                label: 'Archive',
                icon: Icons.archive,
                backgroundColor: theme.colorScheme.secondary,
                iconColor: theme.colorScheme.onSecondary,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item archived')),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Card 2 tapped')));
              },
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Card 3: Full Featured',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Card with all optional features enabled. Swipe both ways: left to archive, right to delete.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Complete Example',
              subtitle: 'Card demonstrating all available features and options',
              leadingImage: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 32,
                ),
              ),
              topRightItems: [
                TopRightItem(
                  label: 'Featured',
                  icon: Icons.star,
                  color: theme.colorScheme.secondary,
                ),
              ],

              bottomRowItems: [
                BottomRowItem(
                  label: 'Status',
                  value: 'Active',
                  valueColor: Colors.green,
                ),
                BottomRowItem(
                  label: 'Priority',
                  value: 'High',
                  valueColor: theme.colorScheme.secondary,
                ),
                BottomRowItem(label: 'ID', value: '#12345'),
              ],
              trailingIcons: [
                TrailingIcon(
                  icon: Icons.edit,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit pressed')),
                    );
                  },
                  tooltip: 'Edit',
                ),
                TrailingIcon(
                  icon: Icons.more_vert,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('More options')),
                    );
                  },
                  tooltip: 'More',
                ),
              ],
              leftSwipeAction: SwipeAction(
                label: 'Archive',
                icon: Icons.archive,
                backgroundColor: theme.colorScheme.secondary,
                iconColor: theme.colorScheme.onSecondary,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item archived')),
                  );
                },
              ),
              rightSwipeAction: SwipeAction(
                label: 'Delete',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item deleted'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Card 3 tapped')));
              },
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About List Item Cards',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'List Item Cards are reusable, swipeable components that can display various types of content and actions. All cards support swipe gestures for quick actions.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Optional Features:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Leading icon or image\n'
                      '• Subtitle text\n'
                      '• Header status tags\n'
                      '• Top-right badges\n'
                      '• Bottom row items (label:value pairs)\n'
                      '• Date tag\n'
                      '• Trailing action icons\n'
                      '• Left swipe action (e.g., Archive)\n'
                      '• Right swipe action (e.g., Delete)',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Swipe Actions:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Swipe left: Archive action (optional)\n'
                      '• Swipe right: Delete action (optional)\n'
                      '• Both actions can be enabled simultaneously',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_list_item_card',
      ).buildFloatingActionButton(context),
    );
  }
}

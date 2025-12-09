import 'package:flutter/material.dart';
import '../widgets/kuba_divider_titled.dart';
import '../widgets/kuba_list_item_card.dart';

class DividerPage extends StatefulWidget {
  const DividerPage({super.key});

  @override
  State<DividerPage> createState() => _DividerPageState();
}

class _DividerPageState extends State<DividerPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Divider Widget'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overview section
            Card(
              elevation: 0,
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.horizontal_rule,
                      size: 48,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Divider Widget',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reusable Material 3 divider with tagged title for dividing page sections',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // First group of 3 list items
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Task Item 1',
                'subtitle': 'First item in the list',
                'icon': Icons.task_alt,
              },
              {
                'title': 'Task Item 2',
                'subtitle': 'Second item in the list',
                'icon': Icons.assignment,
              },
              {
                'title': 'Task Item 3',
                'subtitle': 'Third item in the list',
                'icon': Icons.check_circle,
              },
            ]),
            const SizedBox(height: 16),

            // Centered divider
            KubaDividerTitled(
              title: 'Section',
              variant: DividerVariant.centered,
            ),
            const SizedBox(height: 16),

            // Second group of 3 list items
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Document Item 1',
                'subtitle': 'First document item',
                'icon': Icons.description,
              },
              {
                'title': 'Document Item 2',
                'subtitle': 'Second document item',
                'icon': Icons.folder,
              },
              {
                'title': 'Document Item 3',
                'subtitle': 'Third document item',
                'icon': Icons.insert_drive_file,
              },
            ]),
            const SizedBox(height: 16),

            // Left divider
            KubaDividerTitled(
              title: 'New Section',
              variant: DividerVariant.left,
            ),
            const SizedBox(height: 16),

            // Third group of 3 list items
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Notification Item 1',
                'subtitle': 'First notification',
                'icon': Icons.notifications,
              },
              {
                'title': 'Notification Item 2',
                'subtitle': 'Second notification',
                'icon': Icons.notification_important,
              },
              {
                'title': 'Notification Item 3',
                'subtitle': 'Third notification',
                'icon': Icons.alarm,
              },
            ]),
            const SizedBox(height: 16),

            // Right divider
            KubaDividerTitled(
              title: 'More Info',
              variant: DividerVariant.right,
            ),
            const SizedBox(height: 16),

            // Fourth group of 3 list items
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Settings Item 1',
                'subtitle': 'First settings item',
                'icon': Icons.settings,
              },
              {
                'title': 'Settings Item 2',
                'subtitle': 'Second settings item',
                'icon': Icons.tune,
              },
              {
                'title': 'Settings Item 3',
                'subtitle': 'Third settings item',
                'icon': Icons.build,
              },
            ]),
            const SizedBox(height: 16),

            // Full width divider
            KubaDividerTitled(
              title: 'Additional Details',
              variant: DividerVariant.fullWidth,
            ),
            const SizedBox(height: 24),

            // Usage example
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Usage Example',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        '''KubaDividerTitled(
  title: 'Section',
  variant: DividerVariant.centered,
)

// Custom styling
KubaDividerTitled(
  title: 'Custom Styled',
  variant: DividerVariant.centered,
  tagBackgroundColor: theme.colorScheme.secondaryContainer,
  tagTextColor: theme.colorScheme.onSecondaryContainer,
  spacing: 32.0,
  thickness: 2.0,
)''',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListItemGroup(
    BuildContext context,
    ThemeData theme,
    List<Map<String, dynamic>> items,
  ) {
    return items.map((item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: KubaListItemCard(
          title: item['title'] as String,
          subtitle: item['subtitle'] as String,
          leadingIcon: item['icon'] as IconData,
          leadingIconColor: theme.colorScheme.primary,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${item['title']} tapped')));
          },
        ),
      );
    }).toList();
  }
}

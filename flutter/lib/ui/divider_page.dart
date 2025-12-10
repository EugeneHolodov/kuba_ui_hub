import 'package:flutter/material.dart';
import '../widgets/kuba_divider_titled.dart';
import '../widgets/kuba_list_item_card.dart';
import '../widgets/review_input.dart';

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
      appBar: AppBar(title: const Text('Divider'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Divider Variant 1: Centered',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Title tag centered between divider lines. Best for major section breaks.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
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
            ]),
            const SizedBox(height: 16),
            KubaDividerTitled(
              title: 'Section',
              variant: DividerVariant.centered,
            ),
            const SizedBox(height: 16),
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
            ]),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Divider Variant 2: Left Aligned',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Title tag aligned to the left. Useful for subsections and categories.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
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
            ]),
            const SizedBox(height: 16),
            KubaDividerTitled(
              title: 'New Section',
              variant: DividerVariant.left,
            ),
            const SizedBox(height: 16),
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
            ]),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Divider Variant 3: Right Aligned',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Title tag aligned to the right. Alternative layout for visual variety.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Event Item 1',
                'subtitle': 'First event item',
                'icon': Icons.event,
              },
              {
                'title': 'Event Item 2',
                'subtitle': 'Second event item',
                'icon': Icons.calendar_today,
              },
            ]),
            const SizedBox(height: 16),
            KubaDividerTitled(
              title: 'More Info',
              variant: DividerVariant.right,
            ),
            const SizedBox(height: 16),
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Info Item 1',
                'subtitle': 'First info item',
                'icon': Icons.info,
              },
              {
                'title': 'Info Item 2',
                'subtitle': 'Second info item',
                'icon': Icons.help_outline,
              },
            ]),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Divider Variant 4: Full Width',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Title tag spans full width with divider line above. Best for major section headers.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Additional Item 1',
                'subtitle': 'First additional item',
                'icon': Icons.add_circle,
              },
              {
                'title': 'Additional Item 2',
                'subtitle': 'Second additional item',
                'icon': Icons.extension,
              },
            ]),
            const SizedBox(height: 16),
            KubaDividerTitled(
              title: 'Additional Details',
              variant: DividerVariant.fullWidth,
            ),
            const SizedBox(height: 16),
            ..._buildListItemGroup(context, theme, [
              {
                'title': 'Details Item 1',
                'subtitle': 'First details item',
                'icon': Icons.details,
              },
              {
                'title': 'Details Item 2',
                'subtitle': 'Second details item',
                'icon': Icons.more_horiz,
              },
            ]),
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
                          'About Dividers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dividers with titled tags are reusable components for visually separating sections of content. They provide clear visual breaks while maintaining context with labeled tags.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Divider Variants:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Centered: Title tag centered between divider lines\n'
                      '• Left: Title tag aligned to the left side\n'
                      '• Right: Title tag aligned to the right side\n'
                      '• Full Width: Title tag spans full width with divider above',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Customization Options:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Custom tag background and text colors\n'
                      '• Adjustable spacing and thickness\n'
                      '• Material 3 design system compliant',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Usage Example:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
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
        widgetName: 'kuba_divider_titled',
      ).buildFloatingActionButton(context),
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

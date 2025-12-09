import 'package:flutter/material.dart';
import '../widgets/kuba_list_item_card.dart';
import '../widgets/kuba_animated_item.dart';

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
      appBar: AppBar(
        title: const Text('List Item Card'),
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
                      Icons.list_alt,
                      size: 48,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'List Item Card',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reusable swipeable list item card with optional image, icons, tags, and actions',
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

            // Basic card - minimal
            _buildSectionTitle(context, 'Basic Card (Minimal)'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Basic List Item',
              leadingIcon: Icons.folder_outlined,
              leadingIconColor: const Color.fromARGB(255, 63, 9, 225),
              backgroundColor: Colors.red.shade100,
              trailingIcons: [
                TrailingIcon(
                  icon: Icons.more_vert,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('More options')),
                    );
                  },
                ),
              ],
              headerTags: [
                StatusTag(
                  label: 'Active',
                  icon: Icons.check_circle,
                  backgroundColor: Colors.green.shade100,
                  textColor: Colors.green.shade900,
                ),
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Basic card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With subtitle
            _buildSectionTitle(context, 'With Subtitle'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Card with Subtitle',
              subtitle: 'This is a subtitle description',
              leadingIcon: Icons.description,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Subtitle card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With leading image
            _buildSectionTitle(context, 'With Leading Image'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Item with Image',
              subtitle: 'Card with leading image',
              leadingImage: Container(
                color: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.image,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 32,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With status tags
            _buildSectionTitle(context, 'With Status Tags'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Task Item',
              subtitle: 'Card with multiple status tags',
              leadingIcon: Icons.task_alt,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status tags card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With top-right items
            _buildSectionTitle(context, 'With Top-Right Items'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Card with Top-Right Status',
              subtitle: 'Status tag positioned at top right',
              leadingIcon: Icons.notifications,
              topRightItems: [
                TopRightItem(label: 'Active', color: Colors.green),
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Top-right status card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Card with Multiple Top-Right Items',
              subtitle: 'Multiple badges at top right',
              leadingIcon: Icons.label,
              topRightItems: [
                TopRightItem(label: 'New', color: theme.colorScheme.primary),
                TopRightItem(label: 'Hot', color: Colors.orange),
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Multiple top-right items card tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // With date tag
            _buildSectionTitle(context, 'With Date Tag'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Event Item',
              subtitle: 'Card with date tag',
              leadingIcon: Icons.event,
              dateTag: '2024-01-15',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Date tag card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With trailing icons
            _buildSectionTitle(context, 'With Trailing Icons'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Action Item',
              subtitle: 'Card with trailing action icons',
              leadingIcon: Icons.settings,
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
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Trailing icons card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // With bottom row items
            _buildSectionTitle(context, 'With Bottom Row Items'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Item with Bottom Row',
              subtitle: 'Card with label:value tags at bottom',
              leadingIcon: Icons.info,
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
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bottom row card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // Swipeable examples
            _buildSectionTitle(context, 'Swipeable Cards'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Swipe Right to Delete',
              subtitle: 'Swipe from left to right to delete',
              leadingIcon: Icons.delete_outline,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Swipeable card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Swipe Left to Archive',
              subtitle: 'Swipe from right to left to archive',
              leadingIcon: Icons.archive_outlined,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Archive card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),
            KubaListItemCard(
              title: 'Swipe Both Ways',
              subtitle: 'Swipe left to archive, right to delete',
              leadingIcon: Icons.swipe,
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
              dateTag: '2024-01-15',
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bidirectional swipe card tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Full featured
            _buildSectionTitle(context, 'Full Featured Card'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Complete Example',
              subtitle: 'Card with all features enabled',
              leadingImage: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.onSecondaryContainer,
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
              ],
              trailingIcons: [
                TrailingIcon(
                  icon: Icons.more_vert,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('More options')),
                    );
                  },
                ),
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Full featured card tapped')),
                );
              },
            ),
            const SizedBox(height: 16),

            // Custom content
            _buildSectionTitle(context, 'With Custom Content'),
            const SizedBox(height: 8),
            KubaListItemCard(
              title: 'Custom Layout',
              customContent: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.star,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Content Card',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'You can provide completely custom content',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Custom content card tapped')),
                );
              },
            ),
            const SizedBox(height: 32),

            // Animated items demo
            _buildSectionTitle(context, 'Animated List Items'),
            const SizedBox(height: 8),
            Text(
              'Smooth appearance animations with multiple modes',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Staggered animation example
            _buildSectionTitle(
              context,
              'Staggered Animation (Fade + Slide Left)',
            ),
            const SizedBox(height: 8),
            ...List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: KubaAnimatedItem(
                  mode: KubaAnimationMode.fadeSlideLeft,
                  delay: Duration(milliseconds: index * 150),
                  child: KubaListItemCard(
                    title: 'Animated Item ${index + 1}',
                    subtitle: 'Staggered animation with fade + slide',
                    leadingIcon: Icons.animation,
                    leadingIconColor: theme.colorScheme.primary,
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // Different animation modes
            _buildSectionTitle(context, 'Different Animation Modes'),
            const SizedBox(height: 8),
            KubaAnimatedItem(
              mode: KubaAnimationMode.fade,
              child: KubaListItemCard(
                title: 'Fade Animation',
                subtitle: 'Simple fade in effect',
                leadingIcon: Icons.opacity,
                leadingIconColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            KubaAnimatedItem(
              mode: KubaAnimationMode.slideRight,
              delay: const Duration(milliseconds: 150),
              child: KubaListItemCard(
                title: 'Slide from Right',
                subtitle: 'Slide animation from right side',
                leadingIcon: Icons.arrow_forward,
                leadingIconColor: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            KubaAnimatedItem(
              mode: KubaAnimationMode.scale,
              delay: const Duration(milliseconds: 300),
              child: KubaListItemCard(
                title: 'Scale Animation',
                subtitle: 'Scale from center effect',
                leadingIcon: Icons.zoom_in,
                leadingIconColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 12),
            KubaAnimatedItem(
              mode: KubaAnimationMode.fadeScale,
              delay: const Duration(milliseconds: 450),
              child: KubaListItemCard(
                title: 'Fade + Scale',
                subtitle: 'Combined fade and scale effect',
                leadingIcon: Icons.transform,
                leadingIconColor: Colors.purple,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

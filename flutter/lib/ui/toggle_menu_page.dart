import 'package:flutter/material.dart';
import 'toggle_page.dart';
import 'toggle_variant2_page.dart';
import 'widget_menu_page.dart';
import '../widgets/review_input.dart';

class ToggleMenuPage extends StatelessWidget {
  const ToggleMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'Toggle',
      description: 'Explore different toggle implementations',
      icon: Icons.swap_horiz,
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_toggle',
      ).buildFloatingActionButton(context),
      variants: [
        WidgetVariantItem(
          title: 'Variant 1 - Standard Toggle',
          description: 'Standard two-option toggle with short text labels',
          icon: Icons.swap_horiz,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TogglePage(),
              ),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Variant 2 - Long Text Toggle',
          description: 'Toggle optimized for longer text labels with multiline support',
          icon: Icons.text_fields,
          iconBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ToggleVariant2Page(),
              ),
            );
          },
        ),
      ],
    );
  }
}

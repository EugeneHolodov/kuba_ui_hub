import 'package:flutter/material.dart';
import 'dialog_overview_page.dart';
import 'widget_menu_page.dart';
import '../widgets/review_input.dart';

class DialogMenuPage extends StatelessWidget {
  const DialogMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'Dialog',
      description:
          'Explore Material 3 dialog implementations with brand styling',
      icon: Icons.message,
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_dialog',
      ).buildFloatingActionButton(context),
      variants: [
        WidgetVariantItem(
          title: 'Dialog Overview',
          description: 'See all dialog variants and examples in one place',
          icon: Icons.dashboard,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DialogOverviewPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

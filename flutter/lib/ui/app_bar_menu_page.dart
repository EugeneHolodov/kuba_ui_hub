import 'package:flutter/material.dart';
import 'app_bar_overview_page.dart';
import 'widget_menu_page.dart';
import '../widgets/review_input.dart';

class AppBarMenuPage extends StatelessWidget {
  const AppBarMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'App Bar',
      description: 'Explore the custom app bar widget with brand styling',
      icon: Icons.web,
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_app_bar',
      ).buildFloatingActionButton(context),
      variants: [
        WidgetVariantItem(
          title: 'Standard App Bar',
          description:
              'App bar with flag icon, back button, centered title, and menu',
          icon: Icons.web,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppBarOverviewPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'dashboard_cards_page.dart';
import 'widget_menu_page.dart';
import '../widgets/review_input.dart';

class DashboardCardsMenuPage extends StatelessWidget {
  const DashboardCardsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'Dashboard Cards',
      description:
          'Explore draggable metric cards with animations and customization',
      icon: Icons.dashboard,
      variants: [
        WidgetVariantItem(
          title: 'Dashboard Cards',
          description:
              'Draggable metric cards with animations and customization options',
          icon: Icons.dashboard,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardCardsPage(),
              ),
            );
          },
        ),
      ],
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_dashboard_cards',
      ).buildFloatingActionButton(context),
    );
  }
}

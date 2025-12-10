import 'package:flutter/material.dart';
import 'nav_bar_tabs_overview_page.dart';
import 'nav_bar_tabs_navigation_bar_page.dart';
import 'nav_bar_tabs_navigation_bar_top_page.dart';
import 'nav_bar_tabs_segmented_buttons_page.dart';
import 'widget_menu_page.dart';
import '../widgets/review_input.dart';

class NavBarTabsMenuPage extends StatelessWidget {
  const NavBarTabsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'Nav Bar Tabs',
      description: 'Explore different navbar tabs implementations',
      icon: Icons.tab,
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_nav_bar_tabs',
      ).buildFloatingActionButton(context),
      variants: [
        WidgetVariantItem(
          title: 'Variant 1 - Overview with Lists',
          description: 'Navbar tabs with switchable lists below',
          icon: Icons.dashboard,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBarTabsOverviewPage(),
              ),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Variant 2 - Material 3 NavigationBar',
          description: 'Material 3 NavigationBar with switchable content',
          icon: Icons.navigation,
          iconBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBarTabsNavigationBarPage(),
              ),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Variant 3 - NavigationBar Top',
          description: 'Material 3 NavigationBar at the top of the screen',
          icon: Icons.vertical_align_top,
          iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBarTabsNavigationBarTopPage(),
              ),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Variant 4 - Segmented Buttons',
          description: 'Material 3 SegmentedButtons for navigation',
          icon: Icons.view_module,
          iconBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBarTabsSegmentedButtonsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

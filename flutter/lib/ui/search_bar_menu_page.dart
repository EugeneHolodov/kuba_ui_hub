import 'package:flutter/material.dart';
import 'search_bar_page.dart';
import 'search_bar_with_actions_page.dart';
import 'search_bar_toggle_page.dart';
import 'widget_menu_page.dart';

class SearchBarMenuPage extends StatelessWidget {
  const SearchBarMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetMenuPage(
      widgetName: 'Search Bar',
      description: 'Explore different search bar implementations',
      icon: Icons.search,
      variants: [
        WidgetVariantItem(
          title: 'Variant 1 - Default',
          description: 'Bottom search bar with primary/secondary styling',
          icon: Icons.search,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchBarPage()),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Search Bar + Action Buttons',
          description: 'Search bar with filter menu and optional action button',
          icon: Icons.tune,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchBarWithActionsPage(),
              ),
            );
          },
        ),
        WidgetVariantItem(
          title: 'Search Bar with Toggle',
          description:
              'Search bar with toggle button to switch between search and date picker',
          icon: Icons.swap_horiz,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchBarTogglePage(),
              ),
            );
          },
        ),
        // Add more variants here as they are created
        // WidgetVariantItem(
        //   title: 'Variant 2 - Coming Soon',
        //   description: 'Additional search bar variant',
        //   icon: Icons.search_rounded,
        //   iconBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        //   iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const SearchBarVariant2Page(),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}

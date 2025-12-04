import 'package:flutter/material.dart';
import 'search_bar_page.dart';
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

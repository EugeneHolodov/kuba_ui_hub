import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/kuba_search_bar_bottom.dart';

class SearchBarWithActionsPage extends StatefulWidget {
  const SearchBarWithActionsPage({super.key});

  @override
  State<SearchBarWithActionsPage> createState() =>
      _SearchBarWithActionsPageState();
}

class _SearchBarWithActionsPageState extends State<SearchBarWithActionsPage> {
  String? _searchQuery;

  // Sample data for search
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Apple iPhone 15',
      'description': 'Latest iPhone with A17 chip',
      'category': 'Electronics',
      'deadline': DateTime.now().add(const Duration(days: 5)),
    },
    {
      'title': 'Samsung Galaxy S24',
      'description': 'Flagship Android smartphone',
      'category': 'Electronics',
      'deadline': DateTime.now().add(const Duration(days: 3)),
    },
    {
      'title': 'MacBook Pro 16"',
      'description': 'Powerful laptop for professionals',
      'category': 'Computers',
      'deadline': DateTime.now().add(const Duration(days: 7)),
    },
    {
      'title': 'Dell XPS 13',
      'description': 'Ultrabook with premium design',
      'category': 'Computers',
      'deadline': DateTime.now().add(const Duration(days: 10)),
    },
    {
      'title': 'Sony WH-1000XM5',
      'description': 'Noise-cancelling headphones',
      'category': 'Audio',
      'deadline': DateTime.now().add(const Duration(days: 2)),
    },
    {
      'title': 'AirPods Pro',
      'description': 'Wireless earbuds with ANC',
      'category': 'Audio',
      'deadline': DateTime.now().add(const Duration(days: 4)),
    },
    {
      'title': 'Nike Air Max',
      'description': 'Comfortable running shoes',
      'category': 'Fashion',
      'deadline': DateTime.now().add(const Duration(days: 6)),
    },
    {
      'title': 'Adidas Ultraboost',
      'description': 'Performance running shoes',
      'category': 'Fashion',
      'deadline': DateTime.now().add(const Duration(days: 8)),
    },
    {
      'title': 'Canon EOS R5',
      'description': 'Professional mirrorless camera',
      'category': 'Cameras',
      'deadline': DateTime.now().add(const Duration(days: 12)),
    },
    {
      'title': 'Sony A7 IV',
      'description': 'Full-frame mirrorless camera',
      'category': 'Cameras',
      'deadline': DateTime.now().add(const Duration(days: 9)),
    },
    {
      'title': 'iPad Pro 12.9"',
      'description': 'Large tablet for creative work',
      'category': 'Tablets',
      'deadline': DateTime.now().add(const Duration(days: 11)),
    },
    {
      'title': 'Surface Pro 9',
      'description': '2-in-1 tablet and laptop',
      'category': 'Tablets',
      'deadline': DateTime.now().add(const Duration(days: 15)),
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery == null || _searchQuery!.isEmpty) {
      return _items;
    }
    final query = _searchQuery!.toLowerCase();
    return _items.where((item) {
      return item['title'].toString().toLowerCase().contains(query) ||
          item['description'].toString().toLowerCase().contains(query) ||
          item['category'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Search Bar + Action Buttons'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Results count
          if (_searchQuery != null && _searchQuery!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_filteredItems.length} result${_filteredItems.length != 1 ? 's' : ''} found',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          // List of items
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search term',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Selected: ${item['title'].toString()}',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['title'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        item['category'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['description'].toString(),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Deadline: ${DateFormat('MMM dd, yyyy • HH:mm').format(item['deadline'] as DateTime)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: KubaSearchBarBottom(
        value: _searchQuery,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        isPrimary: true,
        hintText: 'Search products...',
        onSearch: () {
          // Optional: handle search action
          FocusScope.of(context).unfocus();
        },
        actionButtonIcon: Icons.add,
        onActionButtonPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sort button pressed'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        filterOptions: [
          SearchBarFilterOption(
            icon: Icons.category,
            label: 'By Category',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Category selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.calendar_today,
            label: 'By Deadline',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Deadline selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.price_check,
            label: 'Price Range',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter by Price Range selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SearchBarFilterOption(
            icon: Icons.star,
            label: 'Top Rated',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Top Rated filter selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

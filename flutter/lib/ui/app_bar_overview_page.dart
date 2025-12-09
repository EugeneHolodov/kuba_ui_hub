import 'package:flutter/material.dart';
import '../widgets/kuba_app_bar.dart';

class AppBarOverviewPage extends StatefulWidget {
  const AppBarOverviewPage({super.key});

  @override
  State<AppBarOverviewPage> createState() => _AppBarOverviewPageState();
}

class _AppBarOverviewPageState extends State<AppBarOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: KubaAppBar(
        title: 'Label',
        subtitle: 'Subtitle example',
        leadingFlag: Image.asset(
          'assets/icons/norsk.png',
          width: 36,
          height: 27,
          fit: BoxFit.contain,
        ),
        onFlagPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Flag button pressed'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        showBackButton: true,
        onBackPressed: () {
          Navigator.of(context).pop();
        },
        showMenuButton: true,
        onMenuPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Menu button pressed'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            // Usage example section
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Usage Example',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        '''KubaAppBar(
  title: 'Label',
  subtitle: 'Subtitle example',
  leadingFlag: Image.asset('assets/icons/norsk.png'),
  onFlagPressed: () {},
  showBackButton: true,
  onBackPressed: () {},
  showMenuButton: true,
  onMenuPressed: () {},
)''',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

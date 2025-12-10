import 'package:flutter/material.dart';
import '../widgets/kuba_app_bar.dart';

class AppBarOverviewPage extends StatefulWidget {
  const AppBarOverviewPage({super.key});

  @override
  State<AppBarOverviewPage> createState() => _AppBarOverviewPageState();
}

class _AppBarOverviewPageState extends State<AppBarOverviewPage> {
  bool _showSubtitle = true;
  bool _showBackButton = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: KubaAppBar(
        title: 'Label',
        subtitle: _showSubtitle ? 'Subtitle example' : null,
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
        showBackButton: _showBackButton,
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
            // Toggle controls section
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
                        Icon(Icons.toggle_on, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Toggle Controls',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Show Subtitle'),
                      subtitle: const Text('Toggle subtitle visibility'),
                      value: _showSubtitle,
                      onChanged: (value) {
                        setState(() {
                          _showSubtitle = value;
                        });
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text('Show Back Button'),
                      subtitle: const Text('Toggle back arrow visibility'),
                      value: _showBackButton,
                      onChanged: (value) {
                        setState(() {
                          _showBackButton = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
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
  subtitle: ${_showSubtitle ? "'Subtitle example'" : "null"},
  leadingFlag: Image.asset('assets/icons/norsk.png'),
  onFlagPressed: () {},
  showBackButton: $_showBackButton,
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

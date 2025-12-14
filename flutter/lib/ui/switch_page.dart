import 'package:flutter/material.dart';
import '../widgets/kuba_switch.dart';
import '../widgets/review_input.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _primarySwitch = false;
  bool _secondarySwitch = true;
  bool _switchWithSubtitle = false;
  bool _disabledSwitch = true;
  bool _disabledOffSwitch = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Switch with Title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Material 3 switch widget with customizable title and subtitle. Supports primary and secondary color styles.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    KubaSwitch(
                      title: 'Primary Switch',
                      value: _primarySwitch,
                      onChanged: (bool value) {
                        setState(() {
                          _primarySwitch = value;
                        });
                      },
                      accentColor: theme.colorScheme.primary,
                    ),
                    const Divider(height: 32),
                    KubaSwitch(
                      title: 'Secondary Switch',
                      value: _secondarySwitch,
                      onChanged: (bool value) {
                        setState(() {
                          _secondarySwitch = value;
                        });
                      },
                      accentColor: theme.colorScheme.secondary,
                    ),
                    const Divider(height: 32),
                    KubaSwitch(
                      title: 'Switch with Subtitle',
                      subtitle: 'This switch includes a descriptive subtitle',
                      value: _switchWithSubtitle,
                      onChanged: (bool value) {
                        setState(() {
                          _switchWithSubtitle = value;
                        });
                      },
                      accentColor: theme.colorScheme.primary,
                    ),
                    const Divider(height: 32),
                    KubaSwitch(
                      title: 'Disabled Switch (ON)',
                      subtitle: 'This switch is disabled and cannot be toggled',
                      value: _disabledSwitch,
                      onChanged: null,
                      disabled: true,
                      accentColor: theme.colorScheme.primary,
                    ),
                    const Divider(height: 32),
                    KubaSwitch(
                      title: 'Disabled Switch (OFF)',
                      subtitle: 'This switch is disabled and cannot be toggled',
                      value: _disabledOffSwitch,
                      onChanged: null,
                      disabled: true,
                      accentColor: theme.colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Switch Widget',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A reusable Material 3 switch widget with title and optional subtitle. The switch uses Material 3 design principles and can be styled with brand colors. The entire row is tappable for better user experience.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Features:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Material 3 Switch base widget\n'
                      '• Customizable title and subtitle\n'
                      '• Primary and secondary color support\n'
                      '• Disabled state support\n'
                      '• Entire row is tappable\n'
                      '• Fully reusable and customizable',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Color Styles:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Primary: Uses primary color scheme for the switch\n'
                      '• Secondary: Uses secondary color scheme for a different visual style',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_switch',
      ).buildFloatingActionButton(context),
    );
  }
}


import 'package:flutter/material.dart';
import '../widgets/kuba_toggle.dart';
import '../widgets/review_input.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  String? _primaryToggle;
  String? _secondaryToggle;
  bool? _booleanToggle;
  String? _toggleWithSubtitle;
  String? _disabledToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Toggle Widget',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Material 3 toggle widget for selecting one of two options. Supports primary and secondary color styles.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaToggle<String>(
              title: 'Primary Toggle',
              value: _primaryToggle,
              option1: 'Option 1',
              option2: 'Option 2',
              label1: 'Option 1',
              label2: 'Option 2',
              onChanged: (String? value) {
                setState(() {
                  _primaryToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggle<String>(
              title: 'Secondary Toggle',
              value: _secondaryToggle,
              option1: 'Yes',
              option2: 'No',
              label1: 'Yes',
              label2: 'No',
              onChanged: (String? value) {
                setState(() {
                  _secondaryToggle = value;
                });
              },
              accentColor: theme.colorScheme.secondary,
              onAccentColor: theme.colorScheme.onSecondary,
            ),
            const SizedBox(height: 32),
            KubaToggle<bool>(
              title: 'Boolean Toggle',
              value: _booleanToggle,
              option1: true,
              option2: false,
              label1: 'Enabled',
              label2: 'Disabled',
              onChanged: (bool? value) {
                setState(() {
                  _booleanToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggle<String>(
              title: 'Toggle with Subtitle',
              subtitle: 'This toggle includes a descriptive subtitle',
              value: _toggleWithSubtitle,
              option1: 'Public',
              option2: 'Private',
              label1: 'Public',
              label2: 'Private',
              onChanged: (String? value) {
                setState(() {
                  _toggleWithSubtitle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggle<String>(
              title: 'Disabled Toggle',
              subtitle: 'This toggle is disabled and cannot be changed',
              value: _disabledToggle,
              option1: 'Active',
              option2: 'Inactive',
              label1: 'Active',
              label2: 'Inactive',
              onChanged: null,
              disabled: true,
              accentColor: theme.colorScheme.secondary,
              onAccentColor: theme.colorScheme.onSecondary,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'About Toggle Widget',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'A reusable Material 3 toggle widget for selecting one of two options. The toggle uses Material 3 SegmentedButton as the base component and can be styled with brand colors. Supports any type of value (String, bool, enum, etc.) through generics.',
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
              '• Material 3 SegmentedButton base widget\n'
              '• Two option selection\n'
              '• Customizable title and subtitle\n'
              '• Primary and secondary color support\n'
              '• Disabled state support\n'
              '• Generic type support (String, bool, enum, etc.)\n'
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
              '• Primary: Uses primary color scheme for the selected option\n'
              '• Secondary: Uses secondary color scheme for a different visual style',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Usage Example:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'KubaToggle<String>(\n'
                '  title: \'Select Option\',\n'
                '  value: _selectedOption,\n'
                '  option1: \'Option 1\',\n'
                '  option2: \'Option 2\',\n'
                '  label1: \'Option 1\',\n'
                '  label2: \'Option 2\',\n'
                '  onChanged: (value) {\n'
                '    setState(() {\n'
                '      _selectedOption = value;\n'
                '    });\n'
                '  },\n'
                '  accentColor: theme.colorScheme.primary,\n'
                '  onAccentColor: theme.colorScheme.onPrimary,\n'
                ')',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_toggle',
      ).buildFloatingActionButton(context),
    );
  }
}


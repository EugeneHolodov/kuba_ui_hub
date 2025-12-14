import 'package:flutter/material.dart';
import '../widgets/kuba_toggle_variant2.dart';
import '../widgets/review_input.dart';

class ToggleVariant2Page extends StatefulWidget {
  const ToggleVariant2Page({super.key});

  @override
  State<ToggleVariant2Page> createState() => _ToggleVariant2PageState();
}

class _ToggleVariant2PageState extends State<ToggleVariant2Page> {
  String? _primaryToggle;
  String? _secondaryToggle;
  bool? _booleanToggle;
  String? _longTextToggle;
  String? _veryLongTextToggle;
  String? _disabledToggle;
  String? _validationToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle Variant 2'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Long Text Toggle Widget',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Material 3 toggle widget optimized for longer text labels with multiline support.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaToggleVariant2<String>(
              title: 'Primary Toggle',
              value: _primaryToggle,
              option1: 'Option 1',
              option2: 'Option 2',
              label1: 'First Option',
              label2: 'Second Option',
              onChanged: (String? value) {
                setState(() {
                  _primaryToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggleVariant2<String>(
              title: 'Secondary Toggle',
              value: _secondaryToggle,
              option1: 'Yes',
              option2: 'No',
              label1: 'Yes, I agree',
              label2: 'No, I decline',
              onChanged: (String? value) {
                setState(() {
                  _secondaryToggle = value;
                });
              },
              accentColor: theme.colorScheme.secondary,
              onAccentColor: theme.colorScheme.onSecondary,
            ),
            const SizedBox(height: 32),
            KubaToggleVariant2<bool>(
              title: 'Boolean Toggle',
              value: _booleanToggle,
              option1: true,
              option2: false,
              label1: 'Enable notifications',
              label2: 'Disable notifications',
              onChanged: (bool? value) {
                setState(() {
                  _booleanToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggleVariant2<String>(
              title: 'Toggle with Validation',
              subtitle: 'This toggle shows error state when no option is selected',
              value: _validationToggle,
              option1: 'Accept',
              option2: 'Decline',
              label1: 'Accept',
              label2: 'Decline',
              onChanged: (String? value) {
                setState(() {
                  _validationToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
              errorText: _validationToggle == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Long Text Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'These examples demonstrate how the widget handles longer text labels.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaToggleVariant2<String>(
              title: 'Long Text Toggle',
              value: _longTextToggle,
              option1: 'Option 1',
              option2: 'Option 2',
              label1: 'This is a longer option label that demonstrates text wrapping',
              label2: 'Another longer option label with more descriptive text',
              onChanged: (String? value) {
                setState(() {
                  _longTextToggle = value;
                });
              },
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),
            KubaToggleVariant2<String>(
              title: 'Very Long Text Toggle',
              subtitle: 'Shows how the widget handles very long descriptive labels',
              value: _veryLongTextToggle,
              option1: 'Option 1',
              option2: 'Option 2',
              label1: 'Enable notifications for all important updates and alerts',
              label2: 'Disable notifications and manage settings manually',
              onChanged: (String? value) {
                setState(() {
                  _veryLongTextToggle = value;
                });
              },
              accentColor: theme.colorScheme.secondary,
              onAccentColor: theme.colorScheme.onSecondary,
            ),
            const SizedBox(height: 32),
            KubaToggleVariant2<String>(
              title: 'Disabled Toggle',
              subtitle: 'This toggle is disabled and cannot be changed',
              value: _disabledToggle,
              option1: 'Active',
              option2: 'Inactive',
              label1: 'Activate this feature now',
              label2: 'Deactivate this feature',
              onChanged: null,
              disabled: true,
              accentColor: theme.colorScheme.primary,
              onAccentColor: theme.colorScheme.onPrimary,
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
                  'About Toggle Variant 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'A reusable Material 3 toggle widget variant optimized for longer text labels. This variant uses multiline text support with constraints to ensure proper display of longer option labels. Supports up to 3 lines of text per option.',
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
              '• Multiline text support (up to 3 lines)\n'
              '• Text ellipsis for very long labels\n'
              '• Centered text alignment\n'
              '• Validation with error messages\n'
              '• Validation icon (check when valid, error when invalid)\n'
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
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_toggle_variant2',
      ).buildFloatingActionButton(context),
    );
  }
}


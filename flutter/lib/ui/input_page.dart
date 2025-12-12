import 'package:flutter/material.dart';
import '../widgets/kuba_input.dart';
import '../widgets/kuba_input_variant2.dart';
import '../widgets/kuba_number_input.dart';
import '../widgets/review_input.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Variant 1 (Original) states
  String? _primaryInput;
  String? _secondaryInput;
  String? _multilineInput;
  String? _errorInput;

  // Variant 2 states
  String? _primaryInputV2;
  String? _secondaryInputV2;
  String? _multilineInputV2;
  String? _errorInputV2;

  // Number Input states
  int? _primaryNumber;
  int? _secondaryNumber;
  int? _numberWithLimits;
  int? _numberWithError;
  int? _requiredNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Input'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Input Variant 1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Standard input field with label above the input. Supports primary and secondary color styles.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildVariant1Block(),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Input Variant 2',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Input field without label, with icon positioned on the right side. Cleaner, more compact design.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildVariant2Block(),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Number Input',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Number input field with +1/-1 increment/decrement buttons and validation icon.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildNumberInputBlock(),
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
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Input Variants',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Variant 1: Standard input field with label positioned above the input field. Provides clear context for what the user should enter. Supports both single-line and multiline input modes.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Variant 2: Input field without a visible label, with icon positioned on the right side. More compact design suitable for forms with limited space. Also supports multiline and error states.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Number Input: Specialized input field for numeric values with +1/-1 increment/decrement buttons integrated in the prefix area. Features validation icon support (check when valid, error when invalid), min/max value constraints, and customizable step size. Perfect for quantity selectors, counters, and any numeric input that benefits from quick adjustment buttons.',
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
                      '• Single-line and multiline input support\n'
                      '• Error state with error message display\n'
                      '• Primary and secondary color styles\n'
                      '• Customizable accent colors\n'
                      '• Number input with +1/-1 buttons\n'
                      '• Min/max value constraints\n'
                      '• Validation icon support',
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
                      '• Primary: Uses primary color scheme for focus indicators and accents\n'
                      '• Secondary: Uses secondary color scheme for a different visual style',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            // Add bottom padding to prevent content from being hidden behind floating button
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_input',
      ).buildFloatingActionButton(context),
    );
  }

  Widget _buildVariant1Block() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KubaInput(
          value: _primaryInput,
          onChanged: (String? value) {
            setState(() {
              _primaryInput = value;
            });
          },
          labelText: 'Primary Input',
          hintText: 'Enter text',
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaInput(
          value: _secondaryInput,
          onChanged: (String? value) {
            setState(() {
              _secondaryInput = value;
            });
          },
          labelText: 'Secondary Input',
          hintText: 'Enter text',
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
        const SizedBox(height: 24),
        KubaInput(
          value: _multilineInput,
          onChanged: (String? value) {
            setState(() {
              _multilineInput = value;
            });
          },
          labelText: 'Multiline Input',
          hintText: 'Enter multiple lines of text',
          maxLines: 3,
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaInput(
          value: _errorInput,
          onChanged: (String? value) {
            setState(() {
              _errorInput = value;
            });
          },
          labelText: 'Input with Error',
          hintText: 'This field has an error',
          errorText: _errorInput != null && _errorInput!.length < 5
              ? 'Must be at least 5 characters'
              : null,
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
      ],
    );
  }

  Widget _buildVariant2Block() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KubaInputVariant2(
          value: _primaryInputV2,
          onChanged: (String? value) {
            setState(() {
              _primaryInputV2 = value;
            });
          },
          labelText: 'Primary Input',
          hintText: 'Enter text',
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaInputVariant2(
          value: _secondaryInputV2,
          onChanged: (String? value) {
            setState(() {
              _secondaryInputV2 = value;
            });
          },
          labelText: 'Secondary Input',
          hintText: 'Enter text',
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
        const SizedBox(height: 24),
        KubaInputVariant2(
          value: _multilineInputV2,
          onChanged: (String? value) {
            setState(() {
              _multilineInputV2 = value;
            });
          },
          labelText: 'Multiline Input',
          hintText: 'Enter multiple lines of text',
          maxLines: 3,
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaInputVariant2(
          value: _errorInputV2,
          onChanged: (String? value) {
            setState(() {
              _errorInputV2 = value;
            });
          },
          labelText: 'Input with Error',
          hintText: 'This field has an error',
          errorText: _errorInputV2 != null && _errorInputV2!.length < 5
              ? 'Must be at least 5 characters'
              : null,
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
      ],
    );
  }

  Widget _buildNumberInputBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KubaNumberInput(
          value: _primaryNumber,
          onChanged: (int? value) {
            setState(() {
              _primaryNumber = value;
            });
          },
          labelText: 'Primary Number Input',
          hintText: 'Enter number',
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaNumberInput(
          value: _secondaryNumber,
          onChanged: (int? value) {
            setState(() {
              _secondaryNumber = value;
            });
          },
          labelText: 'Secondary Number Input',
          hintText: 'Enter number',
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
        const SizedBox(height: 24),
        KubaNumberInput(
          value: _numberWithLimits,
          onChanged: (int? value) {
            setState(() {
              _numberWithLimits = value;
            });
          },
          labelText: 'Number with Limits',
          hintText: 'Enter number (0-100)',
          min: 0,
          max: 100,
          step: 1,
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaNumberInput(
          value: _requiredNumber,
          onChanged: (int? value) {
            setState(() {
              _requiredNumber = value;
            });
          },
          labelText: 'Required Number Field',
          hintText: 'This field is required',
          errorText: _requiredNumber == null ? 'This field is required' : null,
          accentColor: Theme.of(context).colorScheme.primary,
          onAccentColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 24),
        KubaNumberInput(
          value: _numberWithError,
          onChanged: (int? value) {
            setState(() {
              _numberWithError = value;
            });
          },
          labelText: 'Number with Validation',
          hintText: 'Enter number',
          min: 0,
          max: 50,
          errorText: _numberWithError != null && _numberWithError! > 50
              ? 'Maximum value is 50'
              : null,
          accentColor: Theme.of(context).colorScheme.secondary,
          onAccentColor: Theme.of(context).colorScheme.onSecondary,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/kuba_input.dart';
import '../widgets/kuba_input_variant2.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Input Variants Comparison'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Variant 1 Block
            _buildDividerWithTag('Variant 1 (Original)'),
            const SizedBox(height: 12),
            _buildVariant1Block(),
            const SizedBox(height: 32),

            // Variant 2 Block
            _buildDividerWithTag('Variant 2 (No Label, Icon Right)'),
            const SizedBox(height: 12),
            _buildVariant2Block(),
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

  Widget _buildDividerWithTag(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
        ],
      ),
    );
  }
}

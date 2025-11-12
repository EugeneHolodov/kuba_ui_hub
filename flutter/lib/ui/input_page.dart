import 'package:flutter/material.dart';
import '../widgets/kuba_input.dart';
import '../widgets/review_input.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String? _primaryInput;
  String? _secondaryInput;
  String? _emailInput;
  String? _passwordInput;
  String? _multilineInput;
  String? _errorInput;

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
            // Primary Input
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
            const SizedBox(height: 32),

            // Secondary Input
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
            const SizedBox(height: 32),

            // Email Input
            KubaInput(
              value: _emailInput,
              onChanged: (String? value) {
                setState(() {
                  _emailInput = value;
                });
              },
              labelText: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),

            // Password Input
            KubaInput(
              value: _passwordInput,
              onChanged: (String? value) {
                setState(() {
                  _passwordInput = value;
                });
              },
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
            ),
            const SizedBox(height: 32),

            // Multiline Input
            KubaInput(
              value: _multilineInput,
              onChanged: (String? value) {
                setState(() {
                  _multilineInput = value;
                });
              },
              labelText: 'Multiline Input',
              hintText: 'Enter multiple lines of text',
              maxLines: 4,
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),

            // Input with Error
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
}

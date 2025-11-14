import 'package:flutter/material.dart';
import '../widgets/kuba_button.dart';
import '../widgets/review_input.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Button'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary Buttons
            _buildSection('Primary Mode', [
              KubaButton(
                text: 'Primary Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Primary button pressed')),
                  );
                },
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Primary with Icon',
                prefixIcon: Icons.add,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Primary with icon pressed')),
                  );
                },
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Primary Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ]),
            const SizedBox(height: 32),

            // Secondary Buttons
            _buildSection('Secondary Mode', [
              KubaButton(
                text: 'Secondary Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Secondary button pressed')),
                  );
                },
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Secondary with Icon',
                prefixIcon: Icons.check,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Secondary with icon pressed'),
                    ),
                  );
                },
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Secondary Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ]),
            const SizedBox(height: 32),

            // Transparent Buttons
            _buildSection('Transparent Mode', [
              KubaButton(
                text: 'Transparent Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transparent button pressed')),
                  );
                },
                mode: KubaButtonMode.transparent,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Transparent with Icon',
                prefixIcon: Icons.arrow_forward,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Transparent with icon pressed'),
                    ),
                  );
                },
                mode: KubaButtonMode.transparent,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Transparent Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.transparent,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
            ]),
            const SizedBox(height: 32),

            // Outlined Buttons
            _buildSection('Outlined Mode', [
              KubaButton(
                text: 'Outlined Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Outlined button pressed')),
                  );
                },
                mode: KubaButtonMode.outlined,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Outlined with Icon',
                prefixIcon: Icons.border_color,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Outlined with icon pressed')),
                  );
                },
                mode: KubaButtonMode.outlined,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Outlined Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.outlined,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
            ]),
            const SizedBox(height: 32),

            // Text Buttons
            _buildSection('Text Mode', [
              KubaButton(
                text: 'Text Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text button pressed')),
                  );
                },
                mode: KubaButtonMode.text,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Text with Icon',
                prefixIcon: Icons.text_fields,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text with icon pressed')),
                  );
                },
                mode: KubaButtonMode.text,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Text Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.text,
                accentColor: Theme.of(context).colorScheme.primary,
              ),
            ]),
            const SizedBox(height: 32),

            // Danger Buttons
            _buildSection('Danger Mode', [
              KubaButton(
                text: 'Delete Item',
                prefixIcon: Icons.delete,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delete action triggered')),
                  );
                },
                mode: KubaButtonMode.danger,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Remove',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Remove action triggered')),
                  );
                },
                mode: KubaButtonMode.danger,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Danger Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.danger,
              ),
            ]),
            const SizedBox(height: 32),

            // Scale Prop (Full Width)
            _buildSection('Full Width (scale: true)', [
              KubaButton(
                text: 'Full Width Primary',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Full width button pressed')),
                  );
                },
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
                scale: true,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Full Width Outlined',
                prefixIcon: Icons.check_circle,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Full width outlined pressed'),
                    ),
                  );
                },
                mode: KubaButtonMode.outlined,
                accentColor: Theme.of(context).colorScheme.primary,
                scale: true,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Full Width Danger',
                prefixIcon: Icons.warning,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Full width danger pressed')),
                  );
                },
                mode: KubaButtonMode.danger,
                scale: true,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Full Width Disabled',
                onPressed: () {},
                disabled: true,
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
                scale: true,
              ),
            ]),
            const SizedBox(height: 32),

            // Size Variants
            _buildSection('Size Variants', [
              KubaButton(
                text: 'Small Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Small button pressed')),
                  );
                },
                size: KubaButtonSize.small,
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Medium Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Medium button pressed')),
                  );
                },
                size: KubaButtonSize.medium,
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Large Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Large button pressed')),
                  );
                },
                size: KubaButtonSize.large,
                mode: KubaButtonMode.primary,
                accentColor: Theme.of(context).colorScheme.primary,
                onAccentColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ]),
            const SizedBox(height: 32),

            // All Sizes with Icons
            _buildSection('All Sizes with Icons', [
              KubaButton(
                text: 'Small',
                prefixIcon: Icons.star,
                onPressed: () {},
                size: KubaButtonSize.small,
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Medium',
                prefixIcon: Icons.star,
                onPressed: () {},
                size: KubaButtonSize.medium,
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(height: 12),
              KubaButton(
                text: 'Large',
                prefixIcon: Icons.star,
                onPressed: () {},
                size: KubaButtonSize.large,
                mode: KubaButtonMode.secondary,
                accentColor: Theme.of(context).colorScheme.secondary,
                onAccentColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ]),
            // Add bottom padding to prevent content from being hidden behind floating button
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_button',
      ).buildFloatingActionButton(context),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

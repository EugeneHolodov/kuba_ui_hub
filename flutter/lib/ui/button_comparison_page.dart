import 'package:flutter/material.dart';
import '../widgets/kuba_button.dart' as v1;
import '../widgets/kuba_button_second_version.dart' as v2;
import '../widgets/review_input.dart';

class ButtonComparisonPage extends StatefulWidget {
  const ButtonComparisonPage({super.key});

  @override
  State<ButtonComparisonPage> createState() => _ButtonComparisonPageState();
}

class _ButtonComparisonPageState extends State<ButtonComparisonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Button Style Comparison'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Choose Your Button Style',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Compare both button styles side by side. Both use the same brand colors and props.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Version 1 - Original
                _buildVersionSection(
                  context,
                  'Version 1: Classic Style',
                  'Rounded corners (16px), standard shadows, traditional spacing',
                  [
                    _buildButtonRow(
                      context,
                      'Primary',
                      v1.KubaButton(
                        text: 'Primary Button',
                        onPressed: () {},
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Primary Button',
                        onPressed: () {},
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Secondary',
                      v1.KubaButton(
                        text: 'Secondary',
                        prefixIcon: Icons.star,
                        onPressed: () {},
                        mode: v1.KubaButtonMode.secondary,
                        accentColor: Theme.of(context).colorScheme.secondary,
                        onAccentColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Secondary',
                        prefixIcon: Icons.star,
                        onPressed: () {},
                        mode: v2.KubaButtonMode.secondary,
                        accentColor: Theme.of(context).colorScheme.secondary,
                        onAccentColor: Theme.of(
                          context,
                        ).colorScheme.onSecondary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Outlined',
                      v1.KubaButton(
                        text: 'Outlined',
                        onPressed: () {},
                        mode: v1.KubaButtonMode.outlined,
                        accentColor: Theme.of(context).colorScheme.primary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Outlined',
                        onPressed: () {},
                        mode: v2.KubaButtonMode.outlined,
                        accentColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Text',
                      v1.KubaButton(
                        text: 'Text Button',
                        onPressed: () {},
                        mode: v1.KubaButtonMode.text,
                        accentColor: Theme.of(context).colorScheme.primary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Text Button',
                        onPressed: () {},
                        mode: v2.KubaButtonMode.text,
                        accentColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Danger',
                      v1.KubaButton(
                        text: 'Delete',
                        prefixIcon: Icons.delete,
                        onPressed: () {},
                        mode: v1.KubaButtonMode.danger,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Delete',
                        prefixIcon: Icons.delete,
                        onPressed: () {},
                        mode: v2.KubaButtonMode.danger,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Disabled',
                      v1.KubaButton(
                        text: 'Disabled',
                        onPressed: () {},
                        disabled: true,
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Disabled',
                        onPressed: () {},
                        disabled: true,
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Full Width',
                      v1.KubaButton(
                        text: 'Full Width',
                        onPressed: () {},
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                        scale: true,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Full Width',
                        onPressed: () {},
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                        scale: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Size Variants
                _buildVersionSection(
                  context,
                  'Size Variants Comparison',
                  'Small, Medium, and Large sizes',
                  [
                    _buildButtonRow(
                      context,
                      'Small',
                      v1.KubaButton(
                        text: 'Small',
                        onPressed: () {},
                        size: v1.KubaButtonSize.small,
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Small',
                        onPressed: () {},
                        size: v2.KubaButtonSize.small,
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Medium',
                      v1.KubaButton(
                        text: 'Medium',
                        onPressed: () {},
                        size: v1.KubaButtonSize.medium,
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Medium',
                        onPressed: () {},
                        size: v2.KubaButtonSize.medium,
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    _buildButtonRow(
                      context,
                      'Large',
                      v1.KubaButton(
                        text: 'Large',
                        onPressed: () {},
                        size: v1.KubaButtonSize.large,
                        mode: v1.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      v2.KubaButtonSecondVersion(
                        text: 'Large',
                        onPressed: () {},
                        size: v2.KubaButtonSize.large,
                        mode: v2.KubaButtonMode.primary,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_button_comparison',
      ).buildFloatingActionButton(context),
    );
  }

  Widget _buildVersionSection(
    BuildContext context,
    String title,
    String description,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    String label,
    Widget version1,
    Widget version2,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Version 1',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    version1,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Version 2',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    version2,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

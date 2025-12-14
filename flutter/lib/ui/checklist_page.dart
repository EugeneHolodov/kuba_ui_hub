import 'package:flutter/material.dart';
import '../widgets/kuba_checklist.dart';
import '../widgets/review_input.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  KubaChecklistStatus? _checklist1;
  KubaChecklistStatus? _checklist2;
  KubaChecklistStatus? _checklist3;
  final KubaChecklistStatus? _checklist4 = KubaChecklistStatus.ok;
  final KubaChecklistStatus? _checklist5 = KubaChecklistStatus.na;
  final KubaChecklistStatus? _checklist6 = KubaChecklistStatus.deviation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Checklist'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checklist Variant 1: Basic
            Text(
              'Checklist Variant Primary Color',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Simple checklist item with label only',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
            KubaChecklist(
              value: _checklist1,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist1 = value;
                });
              },
              labelText: 'Basic Checklist Item',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 24),

            KubaChecklist(
              value: _checklist2,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist2 = value;
                });
              },
              labelText: 'Checklist with Description',
              description:
                  'This checklist item includes a description to provide more context.',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 24),

            KubaChecklist(
              value: _checklist3,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist3 = value;
                });
              },
              labelText: 'Secondary Color Checklist',
              description: 'Using secondary brand color',
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
            ),
            const SizedBox(height: 24),

            KubaChecklist(
              value: KubaChecklistStatus.ok,
              onChanged: (KubaChecklistStatus? value) {},
              labelText: 'Disabled Checklist',
              description: 'This checklist is disabled',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              disabled: true,
            ),
            const SizedBox(height: 32),

            // Info card
            Card(
              elevation: 1,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Checklist Features',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Status Options: OK, N/A (Not Applicable), and Deviation.\n\n'
                      'Features: Optional description text, customizable colors (primary, secondary), and disabled state support.\n\n'
                      'Color Styles: Use theme colors (primary, secondary) with matching on-color for text.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                        height: 1.5,
                      ),
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
        widgetName: 'kuba_checklist',
      ).buildFloatingActionButton(context),
    );
  }
}

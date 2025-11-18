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
  KubaChecklistStatus? _checklist4 = KubaChecklistStatus.ok;
  KubaChecklistStatus? _checklist5 = KubaChecklistStatus.na;
  KubaChecklistStatus? _checklist6 = KubaChecklistStatus.deviation;

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
            // Basic Checklist
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
            const SizedBox(height: 32),

            // Checklist with Description
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
            const SizedBox(height: 32),

            // Secondary Color Checklist
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
            const SizedBox(height: 32),

            // Pre-selected OK
            KubaChecklist(
              value: _checklist4,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist4 = value;
                });
              },
              labelText: 'Pre-selected: OK',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),

            // Pre-selected N/A
            KubaChecklist(
              value: _checklist5,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist5 = value;
                });
              },
              labelText: 'Pre-selected: N/A',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),

            // Pre-selected Deviation
            KubaChecklist(
              value: _checklist6,
              onChanged: (KubaChecklistStatus? value) {
                setState(() {
                  _checklist6 = value;
                });
              },
              labelText: 'Pre-selected: Deviation',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 32),

            // Disabled Checklist
            KubaChecklist(
              value: KubaChecklistStatus.ok,
              onChanged: (KubaChecklistStatus? value) {},
              labelText: 'Disabled Checklist',
              description: 'This checklist is disabled',
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              disabled: true,
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

import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../widgets/kuba_signature_input.dart';

/// Overview page demonstrating the KubaSignatureInput widget
class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  Uint8List? _customerSignature;
  Uint8List? _managerSignature;
  Uint8List? _witnessSignature;
  bool _showValidation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signature Input'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Text(
            'Signature Drawing Widget',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'A reusable signature input widget with drawing canvas, timestamp, and preview.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),

          // Features Card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    context,
                    icon: Icons.draw,
                    title: 'Drawing Canvas',
                    description:
                        'Smooth signature drawing with touch or stylus',
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.access_time,
                    title: 'Timestamp',
                    description:
                        'Automatic timestamp when signature is created',
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.visibility,
                    title: 'Preview',
                    description: 'Shows signature preview in a card',
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.edit,
                    title: 'Editable',
                    description: 'Redraw or clear signatures easily',
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.swap_vert,
                    title: 'Bottom Sheet',
                    description: 'Drawing interface in a modal bottom sheet',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Examples Section
          Text(
            'Examples',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Example 1: Customer Signature (Required with validation)
          KubaSignatureInput(
            label: 'Customer Signature',
            hint: 'Tap "Draw" to sign',
            errorText: _showValidation && _customerSignature == null
                ? 'Customer signature required'
                : null,
            onSignatureChanged: (signature) {
              setState(() {
                _customerSignature = signature;
              });
            },
          ),
          const SizedBox(height: 24),

          // Example 2: Manager Approval (Required with validation)
          KubaSignatureInput(
            label: 'Manager Approval',
            hint: 'Manager signature required',
            strokeWidth: 4.0,
            errorText: _showValidation && _managerSignature == null
                ? 'Manager approval required'
                : null,
            onSignatureChanged: (signature) {
              setState(() {
                _managerSignature = signature;
              });
            },
          ),
          const SizedBox(height: 24),

          // Example 3: Witness Signature
          KubaSignatureInput(
            label: 'Witness Signature',
            hint: 'Optional witness signature',
            strokeWidth: 2.5,
            onSignatureChanged: (signature) {
              setState(() {
                _witnessSignature = signature;
              });
            },
          ),
          const SizedBox(height: 32),

          // Status Card
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Signature Status',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStatusRow(
                    context,
                    'Customer',
                    _customerSignature != null,
                  ),
                  _buildStatusRow(
                    context,
                    'Manager',
                    _managerSignature != null,
                  ),
                  _buildStatusRow(
                    context,
                    'Witness',
                    _witnessSignature != null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Submit Button (demo)
          FilledButton(
            onPressed: () {
              if (_customerSignature != null && _managerSignature != null) {
                setState(() {
                  _showValidation = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Signatures submitted successfully!'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              } else {
                setState(() {
                  _showValidation = true;
                });
              }
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Submit All Signatures',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 32),

          // Code Example
          _buildCodeExample(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(BuildContext context, String label, bool isSigned) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isSigned ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
            color: isSigned
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(
            isSigned ? 'Signed' : 'Pending',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isSigned
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExample(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Usage Example',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                '''KubaSignatureInput(
  label: 'Customer Signature',
  hint: 'Tap "Draw" to sign',
  strokeWidth: 3.0,
  onSignatureChanged: (signature) {
    // Handle signature data (Uint8List)
    print('Signature saved!');
  },
)''',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

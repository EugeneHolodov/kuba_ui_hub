import 'package:flutter/material.dart';

enum KubaChecklistStatus { ok, na, deviation }

class KubaChecklist extends StatelessWidget {
  final KubaChecklistStatus? value;
  final ValueChanged<KubaChecklistStatus?> onChanged;
  final String labelText;
  final String? description;
  final Color accentColor;
  final Color onAccentColor;
  final bool disabled;

  const KubaChecklist({
    super.key,
    this.value,
    required this.onChanged,
    this.labelText = 'Checklist Item',
    this.description,
    required this.accentColor,
    required this.onAccentColor,
    this.disabled = false,
  });

  bool get _hasValue => value != null;

  Color _getStatusColor(BuildContext context, KubaChecklistStatus status) {
    switch (status) {
      case KubaChecklistStatus.ok:
        return Colors.green;
      case KubaChecklistStatus.na:
        return Colors.grey.shade600;
      case KubaChecklistStatus.deviation:
        return Theme.of(context).colorScheme.error;
    }
  }

  IconData _getStatusIcon(KubaChecklistStatus status) {
    switch (status) {
      case KubaChecklistStatus.ok:
        return Icons.check_circle;
      case KubaChecklistStatus.na:
        return Icons.remove_circle;
      case KubaChecklistStatus.deviation:
        return Icons.error;
    }
  }

  IconData _getSegmentIcon(KubaChecklistStatus status, bool isSelected) {
    // When selected, show checkmark. When not selected, show status icon
    if (isSelected) {
      return Icons.check;
    }
    return _getStatusIcon(status);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (_hasValue)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _getStatusColor(context, value!),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(value!),
                  size: 16,
                  color: Colors.white,
                ),
              ),
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description!,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SegmentedButton<KubaChecklistStatus>(
            segments: [
              ButtonSegment<KubaChecklistStatus>(
                value: KubaChecklistStatus.ok,
                label: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getSegmentIcon(
                          KubaChecklistStatus.ok,
                          value == KubaChecklistStatus.ok,
                        ),
                        size: 16,
                        color: value == KubaChecklistStatus.ok
                            ? Colors.white
                            : Colors.green,
                      ),
                      const SizedBox(width: 6),
                      const Text('OK'),
                    ],
                  ),
                ),
              ),
              ButtonSegment<KubaChecklistStatus>(
                value: KubaChecklistStatus.na,
                label: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getSegmentIcon(
                          KubaChecklistStatus.na,
                          value == KubaChecklistStatus.na,
                        ),
                        size: 16,
                        color: value == KubaChecklistStatus.na
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      const Text('N/A'),
                    ],
                  ),
                ),
              ),
              ButtonSegment<KubaChecklistStatus>(
                value: KubaChecklistStatus.deviation,
                label: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getSegmentIcon(
                          KubaChecklistStatus.deviation,
                          value == KubaChecklistStatus.deviation,
                        ),
                        size: 16,
                        color: value == KubaChecklistStatus.deviation
                            ? Colors.white
                            : Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: 6),
                      const Flexible(
                        child: Text(
                          'Deviation',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            selected: value != null ? {value!} : {},
            emptySelectionAllowed: true,
            showSelectedIcon: false,
            onSelectionChanged: disabled
                ? null
                : (Set<KubaChecklistStatus> newSelection) {
                    if (newSelection.isEmpty) {
                      onChanged(null);
                    } else {
                      onChanged(newSelection.first);
                    }
                  },
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: accentColor,
              selectedForegroundColor: onAccentColor,
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Colors.black87,
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

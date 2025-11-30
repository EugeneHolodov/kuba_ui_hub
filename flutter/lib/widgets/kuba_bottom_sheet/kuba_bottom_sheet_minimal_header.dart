import 'package:flutter/material.dart';

// Minimal style bottom sheet header widget
class KubaBottomSheetMinimalHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onClose;
  final bool useSecondaryStyle;

  const KubaBottomSheetMinimalHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onClose,
    this.useSecondaryStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle bar (small line)
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: useSecondaryStyle
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: useSecondaryStyle
                            ? Colors.black
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: useSecondaryStyle
                            ? FontWeight.w500
                            : FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: useSecondaryStyle
                              ? Colors.black87
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: useSecondaryStyle
                      ? Colors.black
                      : Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  if (onClose != null) {
                    onClose!();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
        // Divider between header and content
        Container(height: 1, color: Theme.of(context).colorScheme.outline),
      ],
    );
  }
}

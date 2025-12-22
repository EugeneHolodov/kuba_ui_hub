import 'package:flutter/material.dart';

/// Reusable Material 3 Tag widget
///
/// Features:
/// - Displays text with optional icon
/// - Material 3 styling with customizable colors
/// - Fully reusable and customizable
/// - Can be used for any tag view throughout the app
class KubaTag extends StatelessWidget {
  final String? label;
  final DateTime? timestamp;
  final IconData? icon;
  final Color? color;
  final Color? onColor;

  const KubaTag({
    super.key,
    this.label,
    this.timestamp,
    this.icon,
    this.color,
    this.onColor,
  });

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveColor = color ?? colorScheme.primary;
    final effectiveOnColor = onColor ?? colorScheme.primary;

    String tagText = '';

    if (label != null && timestamp != null) {
      final formattedDate = _formatDateTime(timestamp!);
      tagText = '$label • $formattedDate';
    } else if (label != null) {
      tagText = label!;
    } else if (timestamp != null) {
      tagText = _formatDateTime(timestamp!);
    }

    if (tagText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: effectiveColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: effectiveOnColor),
            const SizedBox(width: 6),
          ],
          Text(
            tagText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: effectiveOnColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

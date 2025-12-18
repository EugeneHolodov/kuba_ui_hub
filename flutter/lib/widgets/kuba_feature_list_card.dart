import 'package:flutter/material.dart';
import 'feature_list_chart.dart';

/// Reusable Material 3 Feature List Card widget
///
/// A big card widget that displays:
/// - Title at the top
/// - Chart on the left side (50% of card)
/// - Title and tags on the right side (50% of card)
///
/// Features:
/// - Material 3 styling with brand colors
/// - Fixed 320px height
/// - Full screen width
/// - 50/50 split between chart and info
/// - Max 4 optional tags
/// - Title aligned to top, tags aligned to bottom
/// - Smooth animations
class KubaFeatureListCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final FeatureChartType chartType;
  final List<double> chartValues;
  final List<String>? chartLabels;
  final String rightSideTitle; // e.g., "44 Activities"
  final List<InfoTag> tags;
  final Color? chartPrimaryColor;
  final Color? chartSecondaryColor;
  final Color? chartQuaternaryColor;
  final VoidCallback? onTap;
  final StatusTag? statusTag; // Optional status badge in top-right corner

  KubaFeatureListCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.chartType,
    required this.chartValues,
    this.chartLabels,
    required this.rightSideTitle,
    required this.tags,
    this.chartPrimaryColor,
    this.chartSecondaryColor,
    this.chartQuaternaryColor,
    this.onTap,
    this.statusTag,
  });

  @override
  State<KubaFeatureListCard> createState() => _KubaFeatureListCardState();
}

class _KubaFeatureListCardState extends State<KubaFeatureListCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const cardHeight = 320.0;
    const titleSectionHeight =
        60.0; // Approximate height for title + subtitle + spacing
    const contentHeight =
        cardHeight - titleSectionHeight - 48.0; // 48 for padding

    // Limit tags to max 4
    final displayTags = widget.tags.take(4).toList();

    return SizedBox(
      width: double.infinity,
      height: cardHeight,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Title section
                    Text(
                      widget.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Main content: Chart on left (50%), Tabs on right (50%)
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Chart section (left side) - 50% of width
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: FeatureListChart(
                                type: widget.chartType,
                                values: widget.chartValues,
                                labels: widget.chartLabels,
                                primaryColor: widget.chartPrimaryColor,
                                secondaryColor: widget.chartSecondaryColor,
                                quaternaryColor: widget.chartQuaternaryColor,
                                height:
                                    contentHeight -
                                    24, // Account for container padding
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info section (right side) - 50% of width
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Number and "in total" in one row with underline
                                Container(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: colorScheme.onSurface,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _extractNumber(widget.rightSideTitle),
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                            ),
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          'in total',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer to push tags to bottom
                                const Spacer(),
                                // Tags at bottom - max 4, expand to fill width
                                if (displayTags.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: displayTags
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => Padding(
                                            padding: EdgeInsets.only(
                                              bottom:
                                                  entry.key <
                                                      displayTags.length - 1
                                                  ? 8
                                                  : 0,
                                            ),
                                            child: _buildInfoTag(
                                              context,
                                              entry.value,
                                              colorScheme,
                                              theme,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Status tag in top-right corner
              if (widget.statusTag != null)
                Positioned(
                  top: 16,
                  right: 16,
                  child: _buildStatusTag(
                    context,
                    widget.statusTag!,
                    colorScheme,
                    theme,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Extract number from rightSideTitle (e.g., "358 Activities" -> "358")
  String _extractNumber(String title) {
    // Extract the first number from the string
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(title);
    return match != null ? match.group(0)! : title;
  }

  Widget _buildStatusTag(
    BuildContext context,
    StatusTag statusTag,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusTag.backgroundColor ?? colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: statusTag.borderColor != null
            ? Border.all(color: statusTag.borderColor!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (statusTag.icon != null) ...[
            Icon(
              statusTag.icon,
              size: 14,
              color: statusTag.textColor ?? colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            statusTag.label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: statusTag.textColor ?? colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(
    BuildContext context,
    InfoTag tag,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    // Use passed color to generate tag colors (same logic as kuba_list_item_card)
    final baseColor =
        tag.valueColor ?? tag.colorIndicator ?? colorScheme.primary;
    final tagBackgroundColor =
        tag.backgroundColor ?? baseColor.withOpacity(0.12);
    final borderColor = tag.borderColor ?? baseColor.withOpacity(0.3);
    final labelTextColor =
        tag.textColor ?? colorScheme.onSurface.withOpacity(0.6);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tagBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (tag.colorIndicator != null) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: tag.colorIndicator,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (tag.icon != null) ...[
            Icon(tag.icon, size: 16, color: baseColor),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Label - subtle, smaller text
                Flexible(
                  child: Text(
                    tag.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: labelTextColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (tag.value != null) ...[
                  const SizedBox(width: 6),
                  // Value - prominent, colored text
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100.0),
                    child: Text(
                      tag.value!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: baseColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Model for an info tag displayed at the bottom of the right side
class InfoTag {
  final String label;
  final String? value;
  final Color? colorIndicator; // Color dot to show chart color
  final IconData? icon;
  final Color?
  valueColor; // Base color for value text, border, and background tint
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const InfoTag({
    required this.label,
    this.value,
    this.colorIndicator,
    this.icon,
    this.valueColor,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });
}

/// Model for a status tag displayed in the top-right corner of the card
class StatusTag {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const StatusTag({
    required this.label,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });
}

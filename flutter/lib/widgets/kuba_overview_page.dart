import 'package:flutter/material.dart';

/// Reusable Material 3 Overview Page widget with brand styling
///
/// Features:
/// - Grid layout for metric cards
/// - Customizable metric cards with icons, values, and labels
/// - Responsive design
/// - Optional header section
/// - Fully customizable and reusable
class KubaOverviewPage extends StatelessWidget {
  // Constants
  static const double _defaultPadding = 16.0;
  static const double _defaultSpacing = 16.0;
  static const int _defaultCrossAxisCount = 2;

  final String? title;
  final String? subtitle;
  final List<OverviewMetricCard> metrics;
  final int crossAxisCount;
  final double? padding;
  final double? spacing;
  final Widget? header;
  final Widget? footer;
  final Color? backgroundColor;

  KubaOverviewPage({
    super.key,
    this.title,
    this.subtitle,
    required this.metrics,
    this.crossAxisCount = _defaultCrossAxisCount,
    this.padding,
    this.spacing,
    this.header,
    this.footer,
    this.backgroundColor,
  }) {
    assert(metrics.isNotEmpty, 'Metrics cannot be empty');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = padding ?? _defaultPadding;
    final effectiveSpacing = spacing ?? _defaultSpacing;

    return Container(
      color: backgroundColor ?? theme.colorScheme.surface,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(effectivePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) ...[
              header!,
              SizedBox(height: effectiveSpacing),
            ] else if (title != null || subtitle != null) ...[
              _buildHeader(context, theme),
              SizedBox(height: effectiveSpacing),
            ],
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: effectiveSpacing,
                mainAxisSpacing: effectiveSpacing,
                childAspectRatio: 1.2,
              ),
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                return KubaMetricCard(metric: metrics[index]);
              },
            ),
            if (footer != null) ...[
              SizedBox(height: effectiveSpacing),
              footer!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Text(
            title!,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }
}

/// Metric card widget for overview page
class KubaMetricCard extends StatelessWidget {
  // Constants
  static const double _iconSize = 32.0;
  static const double _padding = 16.0;

  final OverviewMetricCard metric;

  const KubaMetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = metric.iconColor ?? theme.colorScheme.primary;
    final effectiveIconBackgroundColor =
        metric.iconBackgroundColor ?? effectiveIconColor.withOpacity(0.12);

    return Card(
      elevation: metric.elevation ?? 2,
      child: InkWell(
        onTap: metric.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and optional badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: effectiveIconBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      metric.icon,
                      size: _iconSize,
                      color: effectiveIconColor,
                    ),
                  ),
                  if (metric.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            metric.badge!.color ??
                            theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        metric.badge!.text,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              metric.badge!.textColor ??
                              theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              // Value
              Text(
                metric.value,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: metric.valueColor ?? theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Label
              Text(
                metric.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // Optional subtitle
              if (metric.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  metric.subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Overview metric card data model
class OverviewMetricCard {
  final String label;
  final String value;
  final IconData icon;
  final String? subtitle;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? backgroundColor;
  final Color? valueColor;
  final double? elevation;
  final VoidCallback? onTap;
  final MetricBadge? badge;

  const OverviewMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.subtitle,
    this.iconColor,
    this.iconBackgroundColor,
    this.backgroundColor,
    this.valueColor,
    this.elevation,
    this.onTap,
    this.badge,
  });
}

/// Metric badge data model
class MetricBadge {
  final String text;
  final Color? color;
  final Color? textColor;

  const MetricBadge({required this.text, this.color, this.textColor});
}

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

    // Calculate responsive grid parameters
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveParams = _calculateResponsiveGridParams(
      screenWidth,
      crossAxisCount,
      effectivePadding,
      spacing,
    );

    final effectiveCrossAxisCount = responsiveParams.crossAxisCount;
    final aspectRatio = responsiveParams.aspectRatio;
    final effectiveSpacing = responsiveParams.spacing;

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
                crossAxisCount: effectiveCrossAxisCount,
                crossAxisSpacing: effectiveSpacing,
                mainAxisSpacing: effectiveSpacing,
                childAspectRatio: aspectRatio,
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

  /// Calculate responsive grid parameters based on screen width
  /// Returns optimal cross axis count, aspect ratio, and spacing for cards
  static _ResponsiveGridParams _calculateResponsiveGridParams(
    double screenWidth,
    int requestedCrossAxisCount,
    double padding,
    double? customSpacing,
  ) {
    // Define card constraints
    const double minCardWidth = 160.0;
    const double maxCardWidth = 300.0;

    // Use responsive aspect ratio - smaller screens need taller cards (lower ratio)
    // Lower aspect ratio = taller cards relative to width
    double aspectRatio;
    if (screenWidth >= 1200) {
      // Large screens: wider cards can be slightly flatter
      aspectRatio = 1.5;
    } else if (screenWidth >= 600) {
      // Medium screens: balanced ratio
      aspectRatio = 1.3;
    } else {
      // Small screens: taller cards to fit content (1.05 = very tall)
      aspectRatio = 1.05;
    }

    // Calculate responsive spacing based on screen width
    // Larger screens need more spacing to prevent overlap
    // Use custom spacing if provided, otherwise calculate responsive spacing
    double responsiveSpacing;
    if (customSpacing != null) {
      responsiveSpacing = customSpacing;
    } else if (screenWidth >= 1400) {
      // Extra large screens: 24-32px spacing
      responsiveSpacing = 32.0;
    } else if (screenWidth >= 1200) {
      // Large screens (desktop): 20-24px spacing
      responsiveSpacing = 24.0;
    } else if (screenWidth >= 900) {
      // Medium-large screens (tablets landscape): 18-20px spacing
      responsiveSpacing = 20.0;
    } else if (screenWidth >= 600) {
      // Medium screens (tablets portrait): 16-18px spacing
      responsiveSpacing = 18.0;
    } else {
      // Small screens (phones): 16px spacing
      responsiveSpacing = 16.0;
    }

    // Calculate optimal column count based on screen width
    int optimalCrossAxisCount = requestedCrossAxisCount;

    if (screenWidth >= 1400) {
      // Extra large screens: 5-6 columns
      optimalCrossAxisCount = (screenWidth / (maxCardWidth + responsiveSpacing))
          .floor()
          .clamp(5, 6);
    } else if (screenWidth >= 1200) {
      // Large screens (desktop): 4-5 columns
      optimalCrossAxisCount = (screenWidth / (maxCardWidth + responsiveSpacing))
          .floor()
          .clamp(4, 5);
    } else if (screenWidth >= 900) {
      // Medium-large screens (tablets landscape): 3-4 columns
      optimalCrossAxisCount = (screenWidth / (maxCardWidth + responsiveSpacing))
          .floor()
          .clamp(3, 4);
    } else if (screenWidth >= 600) {
      // Medium screens (tablets portrait): 2-3 columns
      optimalCrossAxisCount = (screenWidth / (minCardWidth + responsiveSpacing))
          .floor()
          .clamp(2, 3);
    } else {
      // Small screens (phones): 2 columns
      optimalCrossAxisCount = 2;
    }

    // Use the responsive aspect ratio to ensure proper card proportions
    // This prevents content overflow by guaranteeing adequate height on all screens
    return _ResponsiveGridParams(
      crossAxisCount: optimalCrossAxisCount,
      aspectRatio: aspectRatio,
      spacing: responsiveSpacing,
    );
  }
}

/// Helper class to store responsive grid parameters
class _ResponsiveGridParams {
  final int crossAxisCount;
  final double aspectRatio;
  final double spacing;

  _ResponsiveGridParams({
    required this.crossAxisCount,
    required this.aspectRatio,
    required this.spacing,
  });
}

/// Metric card widget for overview page
class KubaMetricCard extends StatelessWidget {
  // Constants
  static const double _iconSize = 32.0;
  static const double _padding = 12.0;

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
            mainAxisSize: MainAxisSize.min,
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
                    Flexible(
                      child: Container(
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              // Value and text section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Optional subtitle
                  if (metric.subtitle != null) ...[
                    const SizedBox(height: 2),
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

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Reusable Material 3 Chart widget with brand styling
///
/// Features:
/// - Multiple chart types: Line, Bar, Pie
/// - Customizable colors using brand color scheme
/// - Smooth animations on load
/// - Interactive tooltips
/// - Responsive design
/// - Fully customizable and reusable
class KubaChart extends StatefulWidget {
  // Constants
  static const double _defaultHeight = 200.0;
  static const double _padding = 16.0;
  static const double _barSpacing = 8.0;
  static const double _barWidth = 40.0;
  static const double _lineStrokeWidth = 3.0;
  static const double _pointRadius = 5.0;
  static const Duration _defaultAnimationDuration = Duration(
    milliseconds: 1200,
  );

  final ChartType type;
  final List<ChartDataPoint> data;
  final String? title;
  final String? subtitle;
  final double? height;
  final Color? primaryColor;
  final Color? secondaryColor;
  final bool showGrid;
  final bool showLegend;
  final List<String>? labels;
  final VoidCallback? onTap;
  final bool animated;
  final Duration animationDuration;
  final Curve animationCurve;

  KubaChart({
    super.key,
    required this.type,
    required this.data,
    this.title,
    this.subtitle,
    this.height,
    this.primaryColor,
    this.secondaryColor,
    this.showGrid = true,
    this.showLegend = false,
    this.labels,
    this.onTap,
    this.animated = true,
    this.animationDuration = _defaultAnimationDuration,
    this.animationCurve = Curves.easeOutCubic,
  }) {
    assert(data.isNotEmpty, 'Data cannot be empty');
  }

  @override
  State<KubaChart> createState() => _KubaChartState();
}

class _KubaChartState extends State<KubaChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );

    if (widget.animated) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(KubaChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data && widget.animated) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrimaryColor =
        widget.primaryColor ?? theme.colorScheme.primary;
    final effectiveSecondaryColor =
        widget.secondaryColor ?? theme.colorScheme.secondary;
    final effectiveHeight = widget.height ?? KubaChart._defaultHeight;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(KubaChart._padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null || widget.subtitle != null) ...[
                _buildHeader(context, theme),
                const SizedBox(height: 16),
              ],
              // For pie charts with legend, show chart and legend side by side
              if (widget.type == ChartType.pie &&
                  widget.showLegend &&
                  widget.data.length > 1)
                SizedBox(
                  height: effectiveHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return _buildChart(
                              context,
                              theme,
                              effectivePrimaryColor,
                              effectiveSecondaryColor,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: _buildLegend(
                          context,
                          theme,
                          effectivePrimaryColor,
                          isVertical: true,
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
                SizedBox(
                  height: effectiveHeight,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return _buildChart(
                        context,
                        theme,
                        effectivePrimaryColor,
                        effectiveSecondaryColor,
                      );
                    },
                  ),
                ),
                if (widget.showLegend && widget.data.length > 1) ...[
                  const SizedBox(height: 16),
                  _buildLegend(context, theme, effectivePrimaryColor),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildChart(
    BuildContext context,
    ThemeData theme,
    Color primaryColor,
    Color secondaryColor,
  ) {
    switch (widget.type) {
      case ChartType.line:
        return _buildLineChart(context, theme, primaryColor);
      case ChartType.bar:
        return _buildBarChart(context, theme, primaryColor, secondaryColor);
      case ChartType.pie:
        return _buildPieChart(context, theme, primaryColor, secondaryColor);
    }
  }

  Widget _buildLineChart(BuildContext context, ThemeData theme, Color color) {
    return CustomPaint(
      painter: LineChartPainter(
        data: widget.data,
        color: color,
        showGrid: widget.showGrid,
        labels: widget.labels,
        textStyle: theme.textTheme.bodySmall,
        animationValue: widget.animated ? _animation.value : 1.0,
      ),
      child: Container(),
    );
  }

  Widget _buildBarChart(
    BuildContext context,
    ThemeData theme,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return CustomPaint(
      painter: BarChartPainter(
        data: widget.data,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        showGrid: widget.showGrid,
        labels: widget.labels,
        textStyle: theme.textTheme.bodySmall,
        animationValue: widget.animated ? _animation.value : 1.0,
      ),
      child: Container(),
    );
  }

  Widget _buildPieChart(
    BuildContext context,
    ThemeData theme,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return CustomPaint(
      painter: PieChartPainter(
        data: widget.data,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        textStyle: theme.textTheme.bodySmall,
        animationValue: widget.animated ? _animation.value : 1.0,
      ),
      child: Container(),
    );
  }

  Widget _buildLegend(
    BuildContext context,
    ThemeData theme,
    Color primaryColor, {
    bool isVertical = false,
  }) {
    final legendItems = widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;
      final color = index % 2 == 0
          ? primaryColor
          : (widget.secondaryColor ?? theme.colorScheme.secondary);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: point.color ?? color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              point.label ?? 'Item ${index + 1}',
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }).toList();

    if (isVertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: legendItems
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: item,
              ),
            )
            .toList(),
      );
    }

    return Wrap(spacing: 16, runSpacing: 8, children: legendItems);
  }
}

/// Chart data point model
class ChartDataPoint {
  final double value;
  final String? label;
  final Color? color;

  const ChartDataPoint({required this.value, this.label, this.color});
}

/// Chart type enum
enum ChartType { line, bar, pie }

/// Line chart painter
class LineChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final Color color;
  final bool showGrid;
  final List<String>? labels;
  final TextStyle? textStyle;
  final double animationValue;

  LineChartPainter({
    required this.data,
    required this.color,
    this.showGrid = true,
    this.labels,
    this.textStyle,
    this.animationValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.map((d) => d.value).reduce(math.max);
    final minValue = data.map((d) => d.value).reduce(math.min);
    final valueRange = maxValue - minValue;
    final padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;
    final stepX = chartWidth / (data.length - 1).clamp(1, double.infinity);

    // Draw grid
    if (showGrid) {
      final gridPaint = Paint()
        ..color = color.withOpacity(0.1)
        ..strokeWidth = 1;

      // Horizontal grid lines
      for (int i = 0; i <= 4; i++) {
        final y = padding + (chartHeight / 4) * i;
        canvas.drawLine(
          Offset(padding, y),
          Offset(size.width - padding, y),
          gridPaint,
        );
      }
    }

    // Draw line
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = KubaChart._lineStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final x = padding + stepX * i;
      final normalizedValue = valueRange > 0
          ? (data[i].value - minValue) / valueRange
          : 0.5;
      final y = padding + chartHeight - (normalizedValue * chartHeight);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Animate path drawing by showing progressive points
    if (animationValue < 1.0) {
      final animatedPath = Path();
      final visiblePoints = (data.length * animationValue).ceil();
      for (int i = 0; i < visiblePoints && i < data.length; i++) {
        final x = padding + stepX * i;
        final normalizedValue = valueRange > 0
            ? (data[i].value - minValue) / valueRange
            : 0.5;
        final y = padding + chartHeight - (normalizedValue * chartHeight);

        if (i == 0) {
          animatedPath.moveTo(x, y);
        } else {
          // For the last point, interpolate position if animation is partial
          if (i == visiblePoints - 1 && animationValue < 1.0) {
            final pointProgress = (animationValue * data.length) - (i);
            if (pointProgress < 1.0 && i < data.length - 1) {
              final nextX = padding + stepX * (i + 1);
              final nextNormalizedValue = valueRange > 0
                  ? (data[i + 1].value - minValue) / valueRange
                  : 0.5;
              final nextY =
                  padding + chartHeight - (nextNormalizedValue * chartHeight);
              final interpolatedX = x + (nextX - x) * pointProgress;
              final interpolatedY = y + (nextY - y) * pointProgress;
              animatedPath.lineTo(interpolatedX, interpolatedY);
            } else {
              animatedPath.lineTo(x, y);
            }
          } else {
            animatedPath.lineTo(x, y);
          }
        }
      }
      canvas.drawPath(animatedPath, linePaint);
    } else {
      canvas.drawPath(path, linePaint);
    }

    // Draw points (only show points that should be visible based on animation)
    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final visiblePoints = (data.length * animationValue).ceil();
    for (int i = 0; i < visiblePoints && i < data.length; i++) {
      final x = padding + stepX * i;
      final normalizedValue = valueRange > 0
          ? (data[i].value - minValue) / valueRange
          : 0.5;
      final y = padding + chartHeight - (normalizedValue * chartHeight);

      // Fade in the last point if animation is in progress
      if (i == visiblePoints - 1 && animationValue < 1.0) {
        final pointProgress = (animationValue * data.length) - i;
        pointPaint.color = color.withOpacity(pointProgress.clamp(0.0, 1.0));
      } else {
        pointPaint.color = color;
      }

      canvas.drawCircle(Offset(x, y), KubaChart._pointRadius, pointPaint);
    }

    // Draw labels
    if (labels != null && labels!.length == data.length) {
      final labelPaint = textStyle != null
          ? TextPainter(
              text: TextSpan(style: textStyle),
              textDirection: TextDirection.ltr,
            )
          : null;

      for (int i = 0; i < data.length; i++) {
        if (i % (data.length ~/ 4 + 1) == 0 || i == data.length - 1) {
          final x = padding + stepX * i;
          final label = labels![i];
          if (labelPaint != null) {
            labelPaint.text = TextSpan(text: label, style: textStyle);
            labelPaint.layout();
            labelPaint.paint(
              canvas,
              Offset(x - labelPaint.width / 2, size.height - padding + 8),
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.color != color ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.animationValue != animationValue;
  }
}

/// Bar chart painter
class BarChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final Color primaryColor;
  final Color secondaryColor;
  final bool showGrid;
  final List<String>? labels;
  final TextStyle? textStyle;
  final double animationValue;

  BarChartPainter({
    required this.data,
    required this.primaryColor,
    required this.secondaryColor,
    this.showGrid = true,
    this.labels,
    this.textStyle,
    this.animationValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.map((d) => d.value).reduce(math.max);
    final padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;
    final availableWidth =
        chartWidth - (KubaChart._barSpacing * (data.length - 1));
    final barWidth = (availableWidth / data.length).clamp(
      20.0,
      KubaChart._barWidth,
    );

    // Draw grid
    if (showGrid) {
      final gridPaint = Paint()
        ..color = primaryColor.withOpacity(0.1)
        ..strokeWidth = 1;

      for (int i = 0; i <= 4; i++) {
        final y = padding + (chartHeight / 4) * i;
        canvas.drawLine(
          Offset(padding, y),
          Offset(size.width - padding, y),
          gridPaint,
        );
      }
    }

    // Draw bars with animation
    final spacing =
        (chartWidth - (barWidth * data.length)) /
        (data.length - 1).clamp(1, double.infinity);
    for (int i = 0; i < data.length; i++) {
      final x = padding + (barWidth + spacing) * i;
      final normalizedValue = maxValue > 0 ? data[i].value / maxValue : 0;

      // Animate bar height
      final animatedHeight = normalizedValue * chartHeight * animationValue;
      final y = padding + chartHeight - animatedHeight;

      final barColor =
          data[i].color ?? (i % 2 == 0 ? primaryColor : secondaryColor);

      final barPaint = Paint()
        ..color = barColor
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, animatedHeight),
        const Radius.circular(4),
      );

      canvas.drawRRect(rect, barPaint);
    }

    // Draw labels
    if (labels != null && labels!.length == data.length) {
      final labelPaint = textStyle != null
          ? TextPainter(
              text: TextSpan(style: textStyle),
              textDirection: TextDirection.ltr,
            )
          : null;

      for (int i = 0; i < data.length; i++) {
        final x = padding + (barWidth + spacing) * i + barWidth / 2;
        final label = labels![i];
        if (labelPaint != null) {
          labelPaint.text = TextSpan(text: label, style: textStyle);
          labelPaint.layout();
          labelPaint.paint(
            canvas,
            Offset(x - labelPaint.width / 2, size.height - padding + 8),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.animationValue != animationValue;
  }
}

/// Pie chart painter
class PieChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final Color primaryColor;
  final Color secondaryColor;
  final TextStyle? textStyle;
  final double animationValue;

  PieChartPainter({
    required this.data,
    required this.primaryColor,
    required this.secondaryColor,
    this.textStyle,
    this.animationValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final total = data.map((d) => d.value).fold(0.0, (a, b) => a + b);
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    double startAngle = -math.pi / 2;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / total) * 2 * math.pi;

      // Animate sweep angle
      final animatedSweepAngle = sweepAngle * animationValue;

      // Use color from data point if provided, otherwise fall back to alternating colors
      final color =
          data[i].color ?? (i % 2 == 0 ? primaryColor : secondaryColor);

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        animatedSweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.animationValue != animationValue;
  }
}

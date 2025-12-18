import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Simple Material 3 chart widget for feature list cards
/// Supports line, bar, and pie chart types
class FeatureListChart extends StatefulWidget {
  final FeatureChartType type;
  final List<double> values;
  final List<String>? labels;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? quaternaryColor;
  final double height;

  FeatureListChart({
    super.key,
    required this.type,
    required this.values,
    this.labels,
    this.primaryColor,
    this.secondaryColor,
    this.quaternaryColor,
    this.height = 200,
  }) : assert(values.isNotEmpty, 'Values cannot be empty');

  @override
  State<FeatureListChart> createState() => _FeatureListChartState();
}

class _FeatureListChartState extends State<FeatureListChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: 6000,
      ), // Slower, more gentle animation
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    // Continuous loop for smooth animation
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = widget.primaryColor ?? colorScheme.primary;
    final secondaryColor = widget.secondaryColor ?? colorScheme.secondary;
    final tertiaryColor = Colors.green;
    final quaternaryColor = widget.quaternaryColor ?? colorScheme.tertiary;

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          switch (widget.type) {
            case FeatureChartType.line:
              return CustomPaint(
                painter: _LineChartPainter(
                  values: widget.values,
                  labels: widget.labels,
                  color: primaryColor,
                  animationValue: _animation.value,
                ),
                size: Size.infinite,
              );
            case FeatureChartType.bar:
              return CustomPaint(
                painter: _BarChartPainter(
                  values: widget.values,
                  labels: widget.labels,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  animationValue: _animation.value,
                ),
                size: Size.infinite,
              );
            case FeatureChartType.pie:
              return CustomPaint(
                painter: _PieChartPainter(
                  values: widget.values,
                  labels: widget.labels,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  tertiaryColor: tertiaryColor,
                  quaternaryColor: quaternaryColor,
                  animationValue: _animation.value,
                ),
                size: Size.infinite,
              );
          }
        },
      ),
    );
  }
}

enum FeatureChartType { line, bar, pie }

// Line Chart Painter
class _LineChartPainter extends CustomPainter {
  final List<double> values;
  final List<String>? labels;
  final Color color;
  final double animationValue;

  _LineChartPainter({
    required this.values,
    this.labels,
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 16.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    if (values.isEmpty) return;

    final maxValue = values.reduce(math.max);
    final minValue = values.reduce(math.min);
    final range = (maxValue - minValue).clamp(1.0, double.infinity);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < values.length; i++) {
      final x =
          padding +
          (chartWidth / (values.length - 1).clamp(1, double.infinity)) * i;
      final normalizedValue = (values[i] - minValue) / range;

      // Wave animation: add sine wave offset for smooth flowing effect
      final waveOffset =
          math.sin((animationValue * 2 * math.pi) + (i * 0.5)) * 8;
      final y =
          padding + chartHeight - (normalizedValue * chartHeight) + waveOffset;
      final point = Offset(x, y);
      points.add(point);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    canvas.drawPath(path, paint);

    // Draw points with pulsing animation
    for (int i = 0; i < points.length; i++) {
      final pulseSize =
          4 + math.sin((animationValue * 2 * math.pi) + (i * 0.8)) * 1.5;
      canvas.drawCircle(points[i], pulseSize, pointPaint);
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.animationValue != animationValue;
  }
}

// Bar Chart Painter
class _BarChartPainter extends CustomPainter {
  final List<double> values;
  final List<String>? labels;
  final Color primaryColor;
  final Color secondaryColor;
  final double animationValue;

  _BarChartPainter({
    required this.values,
    this.labels,
    required this.primaryColor,
    required this.secondaryColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 16.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    if (values.isEmpty) return;

    final maxValue = values.reduce(math.max);
    final barWidth = (chartWidth - (values.length - 1) * 8) / values.length;
    final barSpacing = 8.0;

    for (int i = 0; i < values.length; i++) {
      final normalizedValue = maxValue > 0 ? values[i] / maxValue : 0.0;

      // Wave animation: each bar oscillates with a phase offset
      final waveProgress = (animationValue + (i * 0.15)) % 1.0;
      final wave = math.sin(waveProgress * 2 * math.pi) * 0.08 + 1.0;
      final barHeight = normalizedValue * chartHeight * wave;

      final x = padding + i * (barWidth + barSpacing);
      final y = padding + chartHeight - barHeight;

      final paint = Paint()
        ..color = i % 2 == 0 ? primaryColor : secondaryColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.animationValue != animationValue;
  }
}

// Pie Chart Painter
class _PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<String>? labels;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color quaternaryColor;
  final double animationValue;

  _PieChartPainter({
    required this.values,
    this.labels,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.quaternaryColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 16.0;
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = math.min(size.width, size.height) / 2 - padding;
    final total = values.fold(0.0, (a, b) => a + b);

    if (total == 0) return;

    // Gentle rotation animation
    final rotationOffset = animationValue * math.pi * 2;
    double startAngle = -math.pi / 2 + rotationOffset;

    final colors = [
      primaryColor,
      secondaryColor,
      tertiaryColor,
      quaternaryColor,
    ];

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * 2 * math.pi;

      // Subtle pulsing for each segment
      final pulse =
          math.sin((animationValue * 2 * math.pi) + (i * 1.2)) * 0.05 + 1.0;
      final segmentRadius = baseRadius * pulse;

      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: segmentRadius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.animationValue != animationValue;
  }
}

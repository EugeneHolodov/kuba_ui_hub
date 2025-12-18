import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'kuba_bottom_sheet/kuba_bottom_sheet.dart';

/// Reusable signature drawing input widget
class KubaSignatureInput extends StatefulWidget {
  final String label;
  final String? hint;
  final ValueChanged<Uint8List?>? onSignatureChanged;
  final Uint8List? initialSignature;
  final bool enabled;
  final double strokeWidth;
  final String? errorText;

  const KubaSignatureInput({
    super.key,
    required this.label,
    this.hint,
    this.onSignatureChanged,
    this.initialSignature,
    this.enabled = true,
    this.strokeWidth = 3.0,
    this.errorText,
  });

  @override
  State<KubaSignatureInput> createState() => _KubaSignatureInputState();
}

class _KubaSignatureInputState extends State<KubaSignatureInput> {
  Uint8List? _signatureData;
  DateTime? _timestamp;

  @override
  void initState() {
    super.initState();
    _signatureData = widget.initialSignature;
    if (_signatureData != null) {
      _timestamp = DateTime.now();
    }
  }

  void _openSignatureDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag:
          false, // Disable swipe-down to prevent accidental closing while drawing
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => KubaBottomSheet(
        title: 'Draw Signature',
        subtitle: 'Use your finger or stylus to sign',
        child: _SignatureDrawer(
          strokeWidth: widget.strokeWidth,
          onSave: (signature) {
            setState(() {
              _signatureData = signature;
              _timestamp = DateTime.now();
            });
            widget.onSignatureChanged?.call(signature);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _clearSignature() {
    setState(() {
      _signatureData = null;
      _timestamp = null;
    });
    widget.onSignatureChanged?.call(null);
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with error/check indicator
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.enabled
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 24,
                height: 24,
                child: widget.errorText != null
                    ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.priority_high,
                          size: 16,
                          color: Colors.white,
                        ),
                      )
                    : _signatureData != null
                    ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: colorScheme.onPrimary,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: InkWell(
                  onTap: widget.enabled ? _openSignatureDrawer : null,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _signatureData != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    _signatureData!,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.draw_outlined,
                                        size: 40,
                                        color: colorScheme.onSurfaceVariant
                                            .withValues(alpha: 0.5),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        widget.hint ?? 'No signature yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: colorScheme
                                                  .onSurfaceVariant
                                                  .withValues(alpha: 0.7),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (_timestamp != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatTimestamp(_timestamp!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: colorScheme
                                                .onSecondaryContainer,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ] else
                              const Spacer(),
                            if (_signatureData != null) ...[
                              IconButton(
                                onPressed: widget.enabled
                                    ? _clearSignature
                                    : null,
                                icon: const Icon(Icons.delete_outline),
                                tooltip: 'Clear signature',
                                style: IconButton.styleFrom(
                                  foregroundColor: colorScheme.error,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            FilledButton.icon(
                              onPressed: widget.enabled
                                  ? _openSignatureDrawer
                                  : null,
                              icon: Icon(
                                _signatureData != null
                                    ? Icons.edit
                                    : Icons.draw,
                                size: 18,
                              ),
                              label: Text(
                                _signatureData != null ? 'Redraw' : 'Draw',
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Reserved space for validation message - seamless with card
              Container(
                height: 20,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 4),
                decoration: BoxDecoration(
                  color: widget.errorText != null
                      ? colorScheme.error.withValues(alpha: 0.02)
                      : colorScheme.surface.withValues(alpha: 0.02),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.errorText ?? ' ',
                  style: TextStyle(
                    color: widget.errorText != null
                        ? colorScheme.error
                        : Colors.transparent,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignatureDrawer extends StatefulWidget {
  final double strokeWidth;
  final ValueChanged<Uint8List>? onSave;

  const _SignatureDrawer({required this.strokeWidth, this.onSave});

  @override
  State<_SignatureDrawer> createState() => _SignatureDrawerState();
}

class _SignatureDrawerState extends State<_SignatureDrawer> {
  final List<DrawingPoint?> _points = [];
  final GlobalKey _signatureKey = GlobalKey();
  bool _hasDrawn = false;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _hasDrawn = true;
      _points.add(
        DrawingPoint(
          point: details.localPosition,
          paint: Paint()
            ..color = Colors
                .black //color.black or color.white
            ..strokeWidth = widget.strokeWidth
            ..strokeCap = StrokeCap.round,
        ),
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _points.add(
        DrawingPoint(
          point: details.localPosition,
          paint: Paint()
            ..color = Colors
                .black //color.black or color.white
            ..strokeWidth = widget.strokeWidth
            ..strokeCap = StrokeCap.round,
        ),
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _points.add(null);
    });
  }

  void _clearSignature() {
    setState(() {
      _points.clear();
      _hasDrawn = false;
    });
  }

  Future<void> _saveSignature() async {
    try {
      final boundary =
          _signatureKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final imageBytes = byteData?.buffer.asUint8List();

      if (imageBytes != null) {
        widget.onSave?.call(imageBytes);
      }
    } catch (e) {
      debugPrint('Error saving signature: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final canvasHeight = MediaQuery.of(context).size.height * 0.4;
    final canvasWidth = MediaQuery.of(context).size.width - 64;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: RepaintBoundary(
              key: _signatureKey,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: Container(
                  width: canvasWidth,
                  height: canvasHeight,
                  color: Colors.white,
                  child: CustomPaint(
                    painter: _SignaturePainter(points: List.from(_points)),
                    size: Size(canvasWidth, canvasHeight),
                    child:
                        Container(), // Empty container to ensure CustomPaint fills the space
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: _hasDrawn ? _clearSignature : null,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: _hasDrawn ? _saveSignature : null,
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Save Signature'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class DrawingPoint {
  final Offset point;
  final Paint paint;

  DrawingPoint({required this.point, required this.paint});
}

class _SignaturePainter extends CustomPainter {
  final List<DrawingPoint?> points;

  _SignaturePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw white background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // Draw signature strokes
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
          points[i]!.point,
          points[i + 1]!.point,
          points[i]!.paint,
        );
      } else if (points[i] != null && points[i + 1] == null) {
        // Draw a point for single taps (create a copy of paint to avoid modifying original)
        final pointPaint = Paint()
          ..color = points[i]!.paint.color
          ..strokeWidth = points[i]!.paint.strokeWidth + 2
          ..strokeCap = points[i]!.paint.strokeCap;
        canvas.drawPoints(ui.PointMode.points, [points[i]!.point], pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter oldDelegate) {
    // Always repaint to ensure signature appears in real-time
    return true;
  }
}

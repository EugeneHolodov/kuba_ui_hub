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
  final Color? strokeColor;
  final double strokeWidth;

  const KubaSignatureInput({
    super.key,
    required this.label,
    this.hint,
    this.onSignatureChanged,
    this.initialSignature,
    this.enabled = true,
    this.strokeColor,
    this.strokeWidth = 3.0,
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
    KubaBottomSheet.show(
      context: context,
      title: 'Draw Signature',
      subtitle: 'Use your finger or stylus to sign',
      actionButtonText: 'Save',
      child: _SignatureDrawer(
        strokeColor: widget.strokeColor ?? Theme.of(context).colorScheme.primary,
        strokeWidth: widget.strokeWidth,
        onSave: (signature) {
          setState(() {
            _signatureData = signature;
            _timestamp = DateTime.now();
          });
          widget.onSignatureChanged?.call(signature);
        },
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Card(
          elevation: 0,
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
                                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.hint ?? 'No signature yet',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
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
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSecondaryContainer,
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
                          onPressed: widget.enabled ? _clearSignature : null,
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Clear signature',
                          style: IconButton.styleFrom(
                            foregroundColor: colorScheme.error,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      FilledButton.icon(
                        onPressed: widget.enabled ? _openSignatureDrawer : null,
                        icon: Icon(
                          _signatureData != null ? Icons.edit : Icons.draw,
                          size: 18,
                        ),
                        label: Text(_signatureData != null ? 'Redraw' : 'Draw'),
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
      ],
    );
  }
}

class _SignatureDrawer extends StatefulWidget {
  final Color strokeColor;
  final double strokeWidth;
  final ValueChanged<Uint8List>? onSave;

  const _SignatureDrawer({
    required this.strokeColor,
    required this.strokeWidth,
    this.onSave,
  });

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
            ..color = widget.strokeColor
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
            ..color = widget.strokeColor
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
      final boundary = _signatureKey.currentContext?.findRenderObject()
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
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
                child: CustomPaint(
                  painter: _SignaturePainter(points: _points),
                  size: Size(
                    MediaQuery.of(context).size.width - 64,
                    MediaQuery.of(context).size.height * 0.4,
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
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
          points[i]!.point,
          points[i + 1]!.point,
          points[i]!.paint,
        );
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
          ui.PointMode.points,
          [points[i]!.point],
          points[i]!.paint..strokeWidth = points[i]!.paint.strokeWidth + 2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}


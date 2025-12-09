import 'package:flutter/material.dart';

/// Animation modes for list item appearance
enum KubaAnimationMode {
  /// Simple fade in
  fade,

  /// Slide from left
  slideLeft,

  /// Slide from right
  slideRight,

  /// Slide from top
  slideTop,

  /// Slide from bottom
  slideBottom,

  /// Scale from center
  scale,

  /// Fade + slide from left
  fadeSlideLeft,

  /// Fade + slide from right
  fadeSlideRight,

  /// Fade + slide from top
  fadeSlideTop,

  /// Fade + slide from bottom
  fadeSlideBottom,

  /// Fade + scale
  fadeScale,
}

/// Reusable animated item widget for smooth list item appearance
///
/// Features:
/// - Multiple animation modes (fade, slide, scale, combinations)
/// - Customizable duration and curve
/// - Staggered animation support via delay
/// - 100% reusable - wrap any widget
///
/// Example:
/// ```dart
/// KubaAnimatedItem(
///   mode: KubaAnimationMode.fadeSlideLeft,
///   delay: Duration(milliseconds: index * 100),
///   child: KubaListItemCard(...),
/// )
/// ```
class KubaAnimatedItem extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// Animation mode
  final KubaAnimationMode mode;

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  /// Delay before animation starts (useful for staggered animations)
  final Duration delay;

  /// Whether to animate on first build
  final bool animateOnInit;

  const KubaAnimatedItem({
    super.key,
    required this.child,
    this.mode = KubaAnimationMode.fade,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.delay = Duration.zero,
    this.animateOnInit = true,
  });

  @override
  State<KubaAnimatedItem> createState() => _KubaAnimatedItemState();
}

class _KubaAnimatedItemState extends State<KubaAnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.animateOnInit) {
      _startAnimation();
    } else {
      _controller.value = 1.0;
    }
  }

  void _startAnimation() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return _buildAnimatedChild();
      },
    );
  }

  Widget _buildAnimatedChild() {
    switch (widget.mode) {
      case KubaAnimationMode.fade:
        return Opacity(opacity: _animation.value, child: widget.child);

      case KubaAnimationMode.slideLeft:
        return Transform.translate(
          offset: Offset(-50 * (1 - _animation.value), 0),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.slideRight:
        return Transform.translate(
          offset: Offset(50 * (1 - _animation.value), 0),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.slideTop:
        return Transform.translate(
          offset: Offset(0, -50 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.slideBottom:
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.scale:
        return Transform.scale(
          scale: _animation.value,
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.fadeSlideLeft:
        return Transform.translate(
          offset: Offset(-30 * (1 - _animation.value), 0),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.fadeSlideRight:
        return Transform.translate(
          offset: Offset(30 * (1 - _animation.value), 0),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.fadeSlideTop:
        return Transform.translate(
          offset: Offset(0, -30 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.fadeSlideBottom:
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );

      case KubaAnimationMode.fadeScale:
        return Transform.scale(
          scale: 0.8 + (0.2 * _animation.value),
          child: Opacity(opacity: _animation.value, child: widget.child),
        );
    }
  }
}

/// Helper widget for animating a list of items with staggered animation
///
/// Automatically applies delay to each item based on its index
///
/// Example:
/// ```dart
/// KubaAnimatedList(
///   items: myItems,
///   mode: KubaAnimationMode.fadeSlideLeft,
///   itemBuilder: (context, item, index) => KubaListItemCard(...),
/// )
/// ```
class KubaAnimatedList extends StatelessWidget {
  /// List of items to animate
  final List<dynamic> items;

  /// Builder function for each item
  final Widget Function(BuildContext context, dynamic item, int index)
  itemBuilder;

  /// Animation mode
  final KubaAnimationMode mode;

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  /// Delay between each item (staggered animation)
  final Duration staggerDelay;

  /// Whether to animate on first build
  final bool animateOnInit;

  const KubaAnimatedList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.mode = KubaAnimationMode.fade,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.staggerDelay = const Duration(milliseconds: 150),
    this.animateOnInit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return KubaAnimatedItem(
          mode: mode,
          duration: duration,
          curve: curve,
          delay: Duration(milliseconds: staggerDelay.inMilliseconds * index),
          animateOnInit: animateOnInit,
          child: itemBuilder(context, item, index),
        );
      }).toList(),
    );
  }
}

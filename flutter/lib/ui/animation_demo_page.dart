import 'package:flutter/material.dart';
import '../widgets/kuba_animated_item.dart';
import '../widgets/kuba_list_item_card.dart';

class AnimationDemoPage extends StatefulWidget {
  final KubaAnimationMode mode;

  const AnimationDemoPage({super.key, required this.mode});

  @override
  State<AnimationDemoPage> createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> {
  bool _showAnimations = false;

  @override
  void initState() {
    super.initState();
    // Trigger animations after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _showAnimations = true;
        });
      }
    });
  }

  void _resetAnimations() {
    setState(() {
      _showAnimations = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _showAnimations = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getModeName(widget.mode)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAnimations,
            tooltip: 'Reset animation',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showAnimations)
              ...List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KubaAnimatedItem(
                    mode: widget.mode,
                    delay: Duration(milliseconds: index * 150),
                    child: KubaListItemCard(
                      title: 'Item ${index + 1}',
                      subtitle: 'Staggered animation item',
                      leadingIcon: _getModeIcon(widget.mode),
                      leadingIconColor: theme.colorScheme.primary,
                      bottomRowItems: [
                        BottomRowItem(
                          label: 'Index',
                          value: '#${index + 1}',
                          valueColor: theme.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 32),

            // Code example section
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Usage Example',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        _getCodeExample(widget.mode),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  IconData _getModeIcon(KubaAnimationMode mode) {
    switch (mode) {
      case KubaAnimationMode.fade:
        return Icons.opacity;
      case KubaAnimationMode.slideLeft:
        return Icons.arrow_back;
      case KubaAnimationMode.slideRight:
        return Icons.arrow_forward;
      case KubaAnimationMode.slideTop:
        return Icons.arrow_upward;
      case KubaAnimationMode.slideBottom:
        return Icons.arrow_downward;
      case KubaAnimationMode.scale:
        return Icons.zoom_in;
      case KubaAnimationMode.fadeSlideLeft:
        return Icons.swipe_left;
      case KubaAnimationMode.fadeSlideRight:
        return Icons.swipe_right;
      case KubaAnimationMode.fadeSlideTop:
        return Icons.swipe_up;
      case KubaAnimationMode.fadeSlideBottom:
        return Icons.swipe_down;
      case KubaAnimationMode.fadeScale:
        return Icons.transform;
    }
  }

  String _getModeName(KubaAnimationMode mode) {
    switch (mode) {
      case KubaAnimationMode.fade:
        return 'Fade';
      case KubaAnimationMode.slideLeft:
        return 'Slide Left';
      case KubaAnimationMode.slideRight:
        return 'Slide Right';
      case KubaAnimationMode.slideTop:
        return 'Slide Top';
      case KubaAnimationMode.slideBottom:
        return 'Slide Bottom';
      case KubaAnimationMode.scale:
        return 'Scale';
      case KubaAnimationMode.fadeSlideLeft:
        return 'Fade + Slide Left';
      case KubaAnimationMode.fadeSlideRight:
        return 'Fade + Slide Right';
      case KubaAnimationMode.fadeSlideTop:
        return 'Fade + Slide Top';
      case KubaAnimationMode.fadeSlideBottom:
        return 'Fade + Slide Bottom';
      case KubaAnimationMode.fadeScale:
        return 'Fade + Scale';
    }
  }

  String _getCodeExample(KubaAnimationMode mode) {
    final modeName = mode.toString().split('.').last;
    return '''KubaAnimatedItem(
  mode: KubaAnimationMode.$modeName,
  delay: Duration(milliseconds: index * 150),
  child: KubaListItemCard(
    title: 'Animated Item',
    subtitle: 'Your content here',
    leadingIcon: Icons.star,
  ),
)''';
  }
}

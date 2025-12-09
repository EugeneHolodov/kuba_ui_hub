import 'package:flutter/material.dart';
import '../widgets/kuba_animated_item.dart';
import '../widgets/kuba_list_item_card.dart';

class AnimationOverviewPage extends StatefulWidget {
  const AnimationOverviewPage({super.key});

  @override
  State<AnimationOverviewPage> createState() => _AnimationOverviewPageState();
}

class _AnimationOverviewPageState extends State<AnimationOverviewPage> {
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
        title: const Text('All Animation Modes'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAnimations,
            tooltip: 'Reset animations',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showAnimations)
              ...KubaAnimationMode.values.asMap().entries.map((entry) {
                final index = entry.key;
                final mode = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KubaAnimatedItem(
                    mode: mode,
                    delay: Duration(milliseconds: (index * 75)),
                    child: KubaListItemCard(
                      title: _getModeName(mode),
                      subtitle: _getModeDescription(mode),
                      leadingIcon: _getModeIcon(mode),
                      leadingIconColor: theme.colorScheme.primary,
                    ),
                  ),
                );
              }),
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

  String _getModeDescription(KubaAnimationMode mode) {
    switch (mode) {
      case KubaAnimationMode.fade:
        return 'Simple fade in effect';
      case KubaAnimationMode.slideLeft:
        return 'Slide from left side';
      case KubaAnimationMode.slideRight:
        return 'Slide from right side';
      case KubaAnimationMode.slideTop:
        return 'Slide from top';
      case KubaAnimationMode.slideBottom:
        return 'Slide from bottom';
      case KubaAnimationMode.scale:
        return 'Scale from center';
      case KubaAnimationMode.fadeSlideLeft:
        return 'Combined fade and slide from left';
      case KubaAnimationMode.fadeSlideRight:
        return 'Combined fade and slide from right';
      case KubaAnimationMode.fadeSlideTop:
        return 'Combined fade and slide from top';
      case KubaAnimationMode.fadeSlideBottom:
        return 'Combined fade and slide from bottom';
      case KubaAnimationMode.fadeScale:
        return 'Combined fade and scale effect';
    }
  }
}

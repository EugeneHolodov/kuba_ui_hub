import 'package:flutter/material.dart';
import 'animation_overview_page.dart';
import 'animation_demo_page.dart';
import '../widgets/kuba_animated_item.dart';

class AnimationMenuPage extends StatelessWidget {
  const AnimationMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Item Animations'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overview Page Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnimationOverviewPage(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.dashboard,
                          color: theme.colorScheme.onPrimaryContainer,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Animation Modes',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'See all animation modes in one place',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Individual animation mode cards
            ...KubaAnimationMode.values.map((mode) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimationDemoPage(mode: mode),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getModeIcon(mode),
                              color: theme.colorScheme.onSecondaryContainer,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getModeName(mode),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getModeDescription(mode),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: theme.colorScheme.secondary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
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

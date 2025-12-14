import 'package:flutter/material.dart';
import '../widgets/kuba_overview_page.dart';
import '../widgets/kuba_animated_item.dart';

class DashboardCardsPage extends StatefulWidget {
  const DashboardCardsPage({super.key});

  @override
  State<DashboardCardsPage> createState() => _DashboardCardsPageState();
}

class _DashboardCardsPageState extends State<DashboardCardsPage> {
  // Company-specific metrics - now mutable for reordering
  late List<OverviewMetricCard> _metrics;

  @override
  void initState() {
    super.initState();
    _metrics = [
      OverviewMetricCard(
        label: 'Followup Activities',
        value: '156',
        icon: Icons.track_changes,
        subtitle: 'Pending: 23',
        iconColor: Colors.blue,
        badge: const MetricBadge(
          text: '12 New',
          color: Colors.orange,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Followup Activities tapped')),
          );
        },
      ),
      OverviewMetricCard(
        label: 'Followup Deviations',
        value: '42',
        icon: Icons.warning_amber,
        subtitle: 'High: 8',
        iconColor: Colors.red,
        badge: const MetricBadge(
          text: 'Action',
          color: Colors.red,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Followup Deviations tapped')),
          );
        },
      ),
      OverviewMetricCard(
        label: 'Risk Analysis',
        value: '89',
        icon: Icons.assessment,
        subtitle: 'High risk: 12',
        iconColor: Colors.orange,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Risk Analysis tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Task Manager',
        value: '234',
        icon: Icons.task_alt,
        subtitle: 'In progress: 45',
        iconColor: Colors.green,
        badge: const MetricBadge(
          text: 'Active',
          color: Colors.green,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Task Manager tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Internal Control',
        value: '67',
        icon: Icons.security,
        subtitle: 'Compliant: 65',
        iconColor: const Color.fromARGB(255, 190, 110, 25),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Internal Control tapped')),
          );
        },
      ),
      OverviewMetricCard(
        label: 'Manuals',
        value: '128',
        icon: Icons.menu_book,
        subtitle: 'Updated: 5',
        iconColor: Colors.teal,
        badge: const MetricBadge(
          text: 'New',
          color: Colors.blue,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Manuals tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Contacts',
        value: '1,234',
        icon: Icons.contacts,
        subtitle: 'Active: 856',
        iconColor: Colors.indigo,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Contacts tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Employees',
        value: '342',
        icon: Icons.people,
        subtitle: 'Active: 298',
        iconColor: Colors.cyan,
        badge: const MetricBadge(
          text: 'Live',
          color: Colors.green,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Employees tapped')));
        },
      ),
    ];
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _metrics.removeAt(oldIndex);
      _metrics.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Cards'), centerTitle: true),
      body: _AnimatedOverviewPage(
        title: 'Dashboard Overview',
        subtitle: 'Overview of key business areas and metrics',
        metrics: _metrics,
        crossAxisCount: 2,
        onReorder: _onReorder,
      ),
    );
  }
}

class _AnimatedOverviewPage extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final List<OverviewMetricCard> metrics;
  final int crossAxisCount;
  final Function(int, int) onReorder;

  const _AnimatedOverviewPage({
    this.title,
    this.subtitle,
    required this.metrics,
    this.crossAxisCount = 2,
    required this.onReorder,
  });

  @override
  State<_AnimatedOverviewPage> createState() => _AnimatedOverviewPageState();
}

class _AnimatedOverviewPageState extends State<_AnimatedOverviewPage>
    with TickerProviderStateMixin {
  static const double _defaultPadding = 16.0;
  static const double _defaultSpacing = 16.0;

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  bool _usePrimaryToneBackground = false;
  bool _usePrimaryToneCardBackground = false;
  bool _disableScalingAnimation = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.metrics.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.95,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Start animations with staggered delays and loop them
    _startAnimations();
  }

  void _startAnimations() {
    if (_disableScalingAnimation) return;

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted && !_disableScalingAnimation) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  void _stopAnimations() {
    for (var controller in _controllers) {
      controller.stop();
      controller.value = 1.0; // Reset to normal scale
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = _defaultPadding;
    final effectiveSpacing = _defaultSpacing;

    // Calculate responsive aspect ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth -
            (effectivePadding * 2) -
            (effectiveSpacing * (widget.crossAxisCount - 1))) /
        widget.crossAxisCount;
    final minCardHeight = 170.0;
    final aspectRatio = cardWidth / minCardHeight;

    final backgroundColor = _usePrimaryToneBackground
        ? theme.colorScheme.primary.withOpacity(0.03)
        : theme.colorScheme.surface;

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(effectivePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null || widget.subtitle != null) ...[
              _buildHeader(context, theme),
              SizedBox(height: effectiveSpacing),
            ],
            // Reorderable grid with animations
            _ReorderableAnimatedGrid(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: effectiveSpacing,
              mainAxisSpacing: effectiveSpacing,
              childAspectRatio: aspectRatio,
              metrics: widget.metrics,
              onReorder: widget.onReorder,
              animations: _animations,
              getAnimationMode: _getAnimationMode,
              usePrimaryToneCardBackground: _usePrimaryToneCardBackground,
            ),
            SizedBox(height: effectiveSpacing),
            // Background switcher
            _buildBackgroundSwitcher(context, theme),
            const SizedBox(height: 8),
            // Card background switcher
            _buildCardBackgroundSwitcher(context, theme),
            const SizedBox(height: 8),
            // Animation switcher
            _buildAnimationSwitcher(context, theme),
          ],
        ),
      ),
    );
  }

  KubaAnimationMode _getAnimationMode(int index) {
    // Alternate between different animation modes for variety
    final modes = [
      KubaAnimationMode.fadeSlideLeft,
      KubaAnimationMode.fadeSlideRight,
      KubaAnimationMode.fadeScale,
      KubaAnimationMode.fadeSlideBottom,
    ];
    return modes[index % modes.length];
  }

  Widget _buildBackgroundSwitcher(BuildContext context, ThemeData theme) {
    return Card(
      elevation: 1,
      child: SwitchListTile(
        title: Text(
          'Primary Tone Background',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          _usePrimaryToneBackground
              ? 'Background has a subtle primary color tone'
              : 'Background is pure white',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        value: _usePrimaryToneBackground,
        onChanged: (value) {
          setState(() {
            _usePrimaryToneBackground = value;
          });
        },
        secondary: Icon(
          _usePrimaryToneBackground ? Icons.palette : Icons.palette_outlined,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCardBackgroundSwitcher(BuildContext context, ThemeData theme) {
    return Card(
      elevation: 1,
      child: SwitchListTile(
        title: Text(
          'Primary Tone Card Background',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          _usePrimaryToneCardBackground
              ? 'Cards have a subtle primary color tone background'
              : 'Cards have white background',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        value: _usePrimaryToneCardBackground,
        onChanged: (value) {
          setState(() {
            _usePrimaryToneCardBackground = value;
          });
        },
        secondary: Icon(
          _usePrimaryToneCardBackground ? Icons.style : Icons.style_outlined,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildAnimationSwitcher(BuildContext context, ThemeData theme) {
    return Card(
      elevation: 1,
      child: SwitchListTile(
        title: Text(
          'Disable Scaling Animation',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          _disableScalingAnimation
              ? 'Cards are static without pulsing animation'
              : 'Cards have pulsing scale animation',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        value: _disableScalingAnimation,
        onChanged: (value) {
          setState(() {
            _disableScalingAnimation = value;
            if (value) {
              _stopAnimations();
            } else {
              _startAnimations();
            }
          });
        },
        secondary: Icon(
          _disableScalingAnimation ? Icons.animation_outlined : Icons.animation,
          color: theme.colorScheme.primary,
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
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }
}

class _ReorderableAnimatedGrid extends StatefulWidget {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final List<OverviewMetricCard> metrics;
  final Function(int, int) onReorder;
  final List<Animation<double>> animations;
  final KubaAnimationMode Function(int) getAnimationMode;
  final bool usePrimaryToneCardBackground;

  const _ReorderableAnimatedGrid({
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.childAspectRatio,
    required this.metrics,
    required this.onReorder,
    required this.animations,
    required this.getAnimationMode,
    required this.usePrimaryToneCardBackground,
  });

  @override
  State<_ReorderableAnimatedGrid> createState() =>
      _ReorderableAnimatedGridState();
}

class _ReorderableAnimatedGridState extends State<_ReorderableAnimatedGrid> {
  int? _draggedIndex;
  int? _targetIndex;

  @override
  Widget build(BuildContext context) {
    // Calculate card dimensions to maintain consistent size during drag
    final screenWidth = MediaQuery.of(context).size.width;
    final effectivePadding = 16.0;
    final cardWidth =
        (screenWidth -
            (effectivePadding * 2) -
            (widget.crossAxisSpacing * (widget.crossAxisCount - 1))) /
        widget.crossAxisCount;
    final cardHeight = cardWidth / widget.childAspectRatio;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: widget.metrics.length,
      itemBuilder: (context, index) {
        final metric = widget.metrics[index];
        final isDragging = _draggedIndex == index;
        final isTarget = _targetIndex == index && _draggedIndex != null;

        return DragTarget<int>(
          onWillAcceptWithDetails: (data) {
            if (data != null && data != index) {
              setState(() {
                _targetIndex = index;
              });
              return true;
            }
            return false;
          },
          onLeave: (data) {
            setState(() {
              _targetIndex = null;
            });
          },
          onAcceptWithDetails: (data) {
            if (data != index) {
              widget.onReorder(data.data, index);
              setState(() {
                _draggedIndex = null;
                _targetIndex = null;
              });
            }
          },
          builder: (context, candidateData, rejectedData) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isTarget
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    : null,
              ),
              child: LongPressDraggable<int>(
                data: index,
                onDragStarted: () {
                  setState(() {
                    _draggedIndex = index;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    _draggedIndex = null;
                    _targetIndex = null;
                  });
                },
                feedback: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Transform.scale(
                      scale: 1.05,
                      child: Opacity(
                        opacity: 0.9,
                        child: _buildStyledCard(context, metric),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: KubaAnimatedItem(
                    mode: widget.getAnimationMode(index),
                    delay: Duration(milliseconds: index * 100),
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedBuilder(
                      animation: widget.animations[index],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: widget.animations[index].value,
                          child: _buildStyledCard(context, metric),
                        );
                      },
                    ),
                  ),
                ),
                child: isDragging
                    ? Opacity(
                        opacity: 0.3,
                        child: KubaAnimatedItem(
                          mode: widget.getAnimationMode(index),
                          delay: Duration(milliseconds: index * 100),
                          duration: const Duration(milliseconds: 500),
                          child: AnimatedBuilder(
                            animation: widget.animations[index],
                            builder: (context, child) {
                              return Transform.scale(
                                scale: widget.animations[index].value,
                                child: _buildStyledCard(context, metric),
                              );
                            },
                          ),
                        ),
                      )
                    : KubaAnimatedItem(
                        mode: widget.getAnimationMode(index),
                        delay: Duration(milliseconds: index * 100),
                        duration: const Duration(milliseconds: 500),
                        child: AnimatedBuilder(
                          animation: widget.animations[index],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: widget.animations[index].value,
                              child: _buildStyledCard(context, metric),
                            );
                          },
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStyledCard(BuildContext context, OverviewMetricCard metric) {
    if (!widget.usePrimaryToneCardBackground) {
      return KubaMetricCard(metric: metric);
    }

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: metric.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildCardContent(context, metric),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, OverviewMetricCard metric) {
    final theme = Theme.of(context);
    final effectiveIconColor = metric.iconColor ?? theme.colorScheme.primary;

    // Use white text for better visibility on primary background
    final valueColor = Colors.white;
    final labelColor = Colors.white.withOpacity(0.9);
    final subtitleColor = Colors.white.withOpacity(0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon and optional badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // White icon with colored background (tag style)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveIconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(metric.icon, size: 32.0, color: Colors.white),
            ),
            if (metric.badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  metric.badge!.text,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: metric.badge!.color ?? theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
        // Value and text section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            // Value
            Text(
              metric.value,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              metric.label,
              style: theme.textTheme.bodyMedium?.copyWith(color: labelColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Optional subtitle
            if (metric.subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                metric.subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: subtitleColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

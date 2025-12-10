import 'package:flutter/material.dart';

/// A reusable Material 3 FAB Menu widget
/// This widget creates an expandable floating action button menu with smooth animations
class KubaFabMenu extends StatefulWidget {
  /// The main icon shown when the menu is closed
  final IconData mainIcon;

  /// The icon shown when the menu is open
  final IconData? openIcon;

  /// List of menu items to display
  final List<FabMenuItem> menuItems;

  /// Background color of the main FAB
  final Color? backgroundColor;

  /// Foreground color of the main FAB
  final Color? foregroundColor;

  /// Whether to show a scrim (overlay) when menu is expanded
  final bool showScrim;

  /// Tooltip for the main FAB
  final String? tooltip;

  /// Callback when menu state changes
  final ValueChanged<bool>? onMenuStateChanged;

  /// Hero tag for the main FAB button
  final Object? heroTag;

  const KubaFabMenu({
    super.key,
    this.mainIcon = Icons.add,
    this.openIcon,
    required this.menuItems,
    this.backgroundColor,
    this.foregroundColor,
    this.showScrim = true,
    this.tooltip,
    this.onMenuStateChanged,
    this.heroTag,
  });

  @override
  State<KubaFabMenu> createState() => _KubaFabMenuState();
}

class _KubaFabMenuState extends State<KubaFabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      widget.onMenuStateChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Menu items
        ScaleTransition(
          scale: _expandAnimation,
          child: FadeTransition(
            opacity: _expandAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var item in widget.menuItems)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildMenuItem(context, item),
                  ),
              ],
            ),
          ),
        ),

        // Main FAB (close button)
        FloatingActionButton(
          heroTag: widget.heroTag,
          onPressed: _toggleMenu,
          tooltip: widget.tooltip,
          shape: _isExpanded
              ? const CircleBorder()
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: widget.backgroundColor ?? colorScheme.primary,
          foregroundColor: widget.foregroundColor ?? colorScheme.onPrimary,
          elevation: _isExpanded ? 2 : 6,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              _isExpanded ? (widget.openIcon ?? Icons.close) : widget.mainIcon,
              key: ValueKey(_isExpanded),
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, FabMenuItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton.extended(
      onPressed: () {
        _toggleMenu();
        item.onPressed();
      },
      tooltip: item.tooltip ?? item.label,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 2,
      heroTag: 'fab_${item.label.toLowerCase().replaceAll(' ', '_')}',
      icon: Icon(item.icon, size: 20),
      label: Text(
        item.label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Represents a single item in the FAB menu
class FabMenuItem {
  /// The icon to display
  final IconData icon;

  /// Label text
  final String label;

  /// Callback when the item is pressed
  final VoidCallback onPressed;

  /// Optional tooltip (defaults to label if not provided)
  final String? tooltip;

  const FabMenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.tooltip,
  });
}

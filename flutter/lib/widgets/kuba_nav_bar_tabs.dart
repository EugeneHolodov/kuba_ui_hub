import 'package:flutter/material.dart';

/// Data class for navbar tab items
class NavBarTab {
  final String label;
  final IconData? icon;
  final int index;

  const NavBarTab({required this.label, this.icon, required this.index});
}

/// Reusable navbar tabs widget
class KubaNavBarTabs extends StatelessWidget {
  final List<NavBarTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final bool isPrimary;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double? height;

  const KubaNavBarTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isPrimary = true,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = isPrimary
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;
    final surfaceColor = theme.colorScheme.surfaceContainerHighest;

    final effectiveSelectedColor = selectedColor ?? primaryColor;
    final effectiveUnselectedColor =
        unselectedColor ?? theme.colorScheme.onSurfaceVariant;
    final effectiveHeight = height ?? 72.0;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = tab.index == selectedIndex;
          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTabChanged(tab.index),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? effectiveSelectedColor.withOpacity(0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(
                            color: effectiveSelectedColor.withOpacity(0.3),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tab.icon != null) ...[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.zero,
                          child: Icon(
                            tab.icon,
                            size: isSelected ? 24 : 20,
                            color: isSelected
                                ? effectiveSelectedColor
                                : effectiveUnselectedColor,
                          ),
                        ),
                        SizedBox(height: isSelected ? 3 : 2),
                      ],
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        style:
                            theme.textTheme.labelMedium?.copyWith(
                              color: isSelected
                                  ? effectiveSelectedColor
                                  : effectiveUnselectedColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: isSelected ? 12 : 11,
                              letterSpacing: isSelected ? 0.4 : 0.2,
                              height: 1.1,
                            ) ??
                            const TextStyle(),
                        child: Text(
                          tab.label,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

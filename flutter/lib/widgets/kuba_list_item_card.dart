import 'package:flutter/material.dart';

/// Reusable Material 3 Swipeable List Item Card widget with brand styling
///
/// Features:
/// - Swipeable from both left and right sides with custom actions
/// - Optional leading image or icon
/// - Title and optional subtitle
/// - Optional status tags (below subtitle) or top-right items (at top right)
/// - Optional date tag
/// - Optional trailing icons
/// - Fully customizable and reusable
class KubaListItemCard extends StatelessWidget {
  // Constants
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 12.0;
  static const double _imageSize = 56.0;
  static const double _iconSize = 24.0;
  static const double _spacing = 12.0;
  static const double _maxTagValueWidth = 100.0;
  static const double _maxTitleWidth = 280.0;
  static const double _maxSubtitleWidth = 260.0;

  final String title;
  final String? subtitle;
  final Widget? leadingImage;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final List<StatusTag>? headerTags;
  final List<TopRightItem>? topRightItems;
  final String? dateTag;
  final List<BottomRowItem>? bottomRowItems;
  final List<TrailingIcon>? trailingIcons;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final double? elevation;
  final SwipeAction? leftSwipeAction;
  final SwipeAction? rightSwipeAction;
  final Widget? customContent;

  const KubaListItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingImage,
    this.leadingIcon,
    this.leadingIconColor,
    this.headerTags,
    this.topRightItems,
    this.dateTag,
    this.bottomRowItems,
    this.trailingIcons,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.elevation,
    this.leftSwipeAction,
    this.rightSwipeAction,
    this.customContent,
  }) : assert(
         leadingImage == null || leadingIcon == null,
         'Cannot provide both leadingImage and leadingIcon',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.surface;
    final effectiveForegroundColor =
        foregroundColor ?? theme.colorScheme.onSurface;

    final cardContent = _buildCardContent(
      context,
      theme,
      effectiveBackgroundColor,
      effectiveForegroundColor,
    );

    // If no swipe actions, return simple card
    if (leftSwipeAction == null && rightSwipeAction == null) {
      return Card(
        elevation: elevation ?? 3.0,
        color: effectiveBackgroundColor,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding,
                  vertical: _verticalPadding,
                ),
            child: cardContent,
          ),
        ),
      );
    }

    // Build swipeable card
    return _buildSwipeableCard(
      context,
      cardContent,
      effectiveBackgroundColor,
      effectiveForegroundColor,
    );
  }

  Widget _buildSwipeableCard(
    BuildContext context,
    Widget cardContent,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    final card = Card(
      elevation: elevation ?? 1.0,
      color: backgroundColor,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
                vertical: _verticalPadding,
              ),
          child: cardContent,
        ),
      ),
    );

    // Determine dismiss direction
    DismissDirection dismissDirection;
    if (leftSwipeAction != null && rightSwipeAction != null) {
      dismissDirection = DismissDirection.horizontal;
    } else if (leftSwipeAction != null) {
      dismissDirection = DismissDirection.startToEnd;
    } else {
      dismissDirection = DismissDirection.endToStart;
    }

    // Build backgrounds - Flutter requires background to be non-null if secondaryBackground is provided
    Widget? backgroundWidget;
    Widget? secondaryBackgroundWidget;

    if (leftSwipeAction != null) {
      backgroundWidget = _buildSwipeBackground(
        context,
        leftSwipeAction!,
        Alignment.centerLeft,
      );
    }

    if (rightSwipeAction != null) {
      secondaryBackgroundWidget = _buildSwipeBackground(
        context,
        rightSwipeAction!,
        Alignment.centerRight,
      );
      // If secondaryBackground is provided but background is not, provide an empty background
      if (backgroundWidget == null) {
        backgroundWidget = Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }
    }

    return Dismissible(
      key: Key(
        'swipeable_${title.hashCode}_${leftSwipeAction?.label}_${rightSwipeAction?.label}',
      ),
      direction: dismissDirection,
      background: backgroundWidget,
      secondaryBackground: secondaryBackgroundWidget,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd &&
            leftSwipeAction != null) {
          leftSwipeAction!.onAction();
        } else if (direction == DismissDirection.endToStart &&
            rightSwipeAction != null) {
          rightSwipeAction!.onAction();
        }
      },
      child: card,
    );
  }

  Widget _buildSwipeBackground(
    BuildContext context,
    SwipeAction action,
    Alignment alignment,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: action.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: alignment == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (action.icon != null) ...[
            Icon(action.icon, color: action.iconColor, size: _iconSize),
            const SizedBox(width: 8),
          ],
          Text(
            action.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: action.iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(
    BuildContext context,
    ThemeData theme,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    if (customContent != null) {
      return customContent!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main content row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading image or icon
            if (leadingImage != null || leadingIcon != null)
              _buildLeading(context, theme),
            if (leadingImage != null || leadingIcon != null)
              const SizedBox(width: _spacing),

            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title row with top-right items and date tag
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: _maxTitleWidth,
                          ),
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: foregroundColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Top-right items (status tags, badges, etc.)
                      if (topRightItems != null &&
                          topRightItems!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          alignment: WrapAlignment.end,
                          children: topRightItems!
                              .map(
                                (item) =>
                                    _buildTopRightItem(context, theme, item),
                              )
                              .toList(),
                        ),
                      ],
                      if (dateTag != null) ...[
                        const SizedBox(width: 8),
                        _buildDateTag(context, theme, foregroundColor),
                      ],
                    ],
                  ),

                  // Subtitle
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _maxSubtitleWidth,
                      ),
                      child: Text(
                        subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: foregroundColor.withOpacity(0.7),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],

                  // Status tags (below subtitle for backward compatibility)
                  if (headerTags != null && headerTags!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: headerTags!
                          .map((tag) => _buildStatusTag(context, theme, tag))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),

            // Trailing icons
            if (trailingIcons != null && trailingIcons!.isNotEmpty) ...[
              const SizedBox(width: _spacing),
              _buildTrailingIcons(context, theme),
            ],
          ],
        ),

        // Bottom row with label:value tags - starts from left edge, right under leading icon
        if (bottomRowItems != null && bottomRowItems!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildBottomRow(context, theme, foregroundColor),
        ],
      ],
    );
  }

  Widget _buildLeading(BuildContext context, ThemeData theme) {
    if (leadingImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: _imageSize,
          height: _imageSize,
          child: leadingImage!,
        ),
      );
    }

    if (leadingIcon != null) {
      return Container(
        width: _imageSize,
        height: _imageSize,
        decoration: BoxDecoration(
          color: (leadingIconColor ?? theme.colorScheme.primaryContainer)
              .withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          leadingIcon,
          size: _iconSize,
          color: leadingIconColor ?? theme.colorScheme.primary,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDateTag(BuildContext context, ThemeData theme, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        dateTag!,
        style: theme.textTheme.bodySmall?.copyWith(
          color: textColor.withOpacity(0.7),
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildStatusTag(BuildContext context, ThemeData theme, StatusTag tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tag.backgroundColor ?? theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tag.icon != null) ...[
            Icon(
              tag.icon,
              size: 14,
              color: tag.textColor ?? theme.colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            tag.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: tag.textColor ?? theme.colorScheme.onPrimaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRightItem(
    BuildContext context,
    ThemeData theme,
    TopRightItem item,
  ) {
    // Use passed color to generate tag colors (same logic as bottomRowItems)
    final baseColor = item.color ?? theme.colorScheme.primary;
    final tagBackgroundColor =
        item.backgroundColor ?? baseColor.withOpacity(0.12);
    final borderColor = baseColor.withOpacity(0.3);
    final textIconColor = item.textColor ?? baseColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tagBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(item.icon, size: 14, color: textIconColor),
            const SizedBox(width: 6),
          ],
          // Constrain width and show ellipsis if too long
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxTagValueWidth),
            child: Text(
              item.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: textIconColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingIcons(BuildContext context, ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: trailingIcons!
          .map(
            (icon) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: IconButton(
                icon: Icon(icon.icon),
                iconSize: _iconSize,
                color: icon.color ?? theme.colorScheme.onSurfaceVariant,
                onPressed: icon.onPressed,
                tooltip: icon.tooltip,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBottomRow(
    BuildContext context,
    ThemeData theme,
    Color foregroundColor,
  ) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: bottomRowItems!
          .map(
            (item) =>
                _buildBottomRowItem(context, theme, item, foregroundColor),
          )
          .toList(),
    );
  }

  Widget _buildBottomRowItem(
    BuildContext context,
    ThemeData theme,
    BottomRowItem item,
    Color foregroundColor,
  ) {
    // Use passed color to generate tag colors
    final baseColor = item.valueColor ?? theme.colorScheme.primary;
    final tagBackgroundColor =
        item.backgroundColor ?? baseColor.withOpacity(0.12);
    final borderColor = baseColor.withOpacity(0.3);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tagBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label - subtle, smaller text
          Text(
            item.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: foregroundColor.withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 6),
          // Value - prominent, colored text using passed color
          // Constrain width and show ellipsis if too long
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxTagValueWidth),
            child: Text(
              item.value,
              style: theme.textTheme.bodySmall?.copyWith(
                color: baseColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Status tag data model
class StatusTag {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const StatusTag({
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });
}

/// Trailing icon data model
class TrailingIcon {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? tooltip;

  const TrailingIcon({
    required this.icon,
    this.onPressed,
    this.color,
    this.tooltip,
  });
}

/// Swipe action data model
class SwipeAction {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onAction;

  const SwipeAction({
    required this.label,
    this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onAction,
  });
}

/// Top-right item data model for badges/tags at top right of card
class TopRightItem {
  final String label;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final Color? textColor;

  const TopRightItem({
    required this.label,
    this.icon,
    this.color,
    this.backgroundColor,
    this.textColor,
  });
}

/// Bottom row item data model for label:value tags at bottom of card
class BottomRowItem {
  final String label;
  final String value;
  final Color? valueColor;
  final Color? backgroundColor;

  const BottomRowItem({
    required this.label,
    required this.value,
    this.valueColor,
    this.backgroundColor,
  });
}

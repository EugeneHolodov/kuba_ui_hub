import 'package:flutter/material.dart';

/// Reusable Material 3 Attachment widget with brand styling
///
/// Features:
/// - Supports multiple attachment types (file, document, article, image, video, audio, pdf, doc, xlsx, etc.)
/// - Consistent appearance for all attachment types
/// - Optional checkbox for multiple selection
/// - File name, size, and type display
/// - Swipeable from both left and right sides with custom actions
/// - Fully customizable and reusable
class KubaAttachment extends StatelessWidget {
  // Constants
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 12.0;
  static const double _iconSize = 40.0;
  static const double _checkboxSize = 24.0;
  static const double _spacing = 12.0;
  static const double _swipeIconSize = 24.0;

  final String fileName;
  final AttachmentType type;
  final String? fileSize;
  final bool isSelected;
  final bool showCheckbox;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onSelectionChanged;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final double? elevation;
  final SwipeAction? leftSwipeAction;
  final SwipeAction? rightSwipeAction;

  const KubaAttachment({
    super.key,
    required this.fileName,
    required this.type,
    this.fileSize,
    this.isSelected = false,
    this.showCheckbox = false,
    this.onTap,
    this.onSelectionChanged,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.elevation,
    this.leftSwipeAction,
    this.rightSwipeAction,
  });

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
        elevation: elevation ?? 1.0,
        color: effectiveBackgroundColor,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () {
            if (showCheckbox && onSelectionChanged != null) {
              onSelectionChanged!(!isSelected);
            } else {
              onTap?.call();
            }
          },
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
        onTap: () {
          if (showCheckbox && onSelectionChanged != null) {
            onSelectionChanged!(!isSelected);
          } else {
            onTap?.call();
          }
        },
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
      backgroundWidget ??= Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Dismissible(
      key: Key(
        'swipeable_${fileName.hashCode}_${leftSwipeAction?.label}_${rightSwipeAction?.label}',
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
            Icon(action.icon, color: action.iconColor, size: _swipeIconSize),
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
    return Row(
      children: [
        // Attachment icon
        _buildAttachmentIcon(context, theme),

        const SizedBox(width: _spacing),

        // File info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // File name
              Text(
                fileName,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // File size and type
              if (fileSize != null || type != AttachmentType.file) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (fileSize != null) ...[
                      Text(
                        fileSize!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foregroundColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      if (type != AttachmentType.file) ...[
                        Text(
                          ' • ',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: foregroundColor.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                    if (type != AttachmentType.file)
                      Text(
                        _getTypeLabel(type),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foregroundColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),

        // Checkbox (optional) - on the right side
        if (showCheckbox) ...[
          const SizedBox(width: _spacing),
          SizedBox(
            width: _checkboxSize,
            height: _checkboxSize,
            child: Checkbox(
              value: isSelected,
              onChanged: onSelectionChanged != null
                  ? (value) => onSelectionChanged!(value ?? false)
                  : null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAttachmentIcon(BuildContext context, ThemeData theme) {
    final iconData = _getIconForType(type);
    final iconColor = _getIconColorForType(context, type);

    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, size: 24, color: iconColor),
    );
  }

  IconData _getIconForType(AttachmentType type) {
    switch (type) {
      case AttachmentType.image:
        return Icons.image;
      case AttachmentType.video:
        return Icons.video_file;
      case AttachmentType.audio:
        return Icons.audio_file;
      case AttachmentType.pdf:
        return Icons.picture_as_pdf;
      case AttachmentType.doc:
        return Icons.description;
      case AttachmentType.xlsx:
        return Icons.table_chart;
      case AttachmentType.document:
        return Icons.insert_drive_file;
      case AttachmentType.article:
        return Icons.article;
      case AttachmentType.file:
        return Icons.attach_file;
    }
  }

  Color _getIconColorForType(BuildContext context, AttachmentType type) {
    final theme = Theme.of(context);
    switch (type) {
      case AttachmentType.image:
        return Colors.purple;
      case AttachmentType.video:
        return Colors.red;
      case AttachmentType.audio:
        return Colors.orange;
      case AttachmentType.pdf:
        return Colors.red.shade700;
      case AttachmentType.doc:
        return Colors.blue;
      case AttachmentType.xlsx:
        return Colors.green;
      case AttachmentType.document:
        return theme.colorScheme.primary;
      case AttachmentType.article:
        return theme.colorScheme.secondary;
      case AttachmentType.file:
        return theme.colorScheme.primary;
    }
  }

  String _getTypeLabel(AttachmentType type) {
    switch (type) {
      case AttachmentType.image:
        return 'Image';
      case AttachmentType.video:
        return 'Video';
      case AttachmentType.audio:
        return 'Audio';
      case AttachmentType.pdf:
        return 'PDF';
      case AttachmentType.doc:
        return 'Document';
      case AttachmentType.xlsx:
        return 'Spreadsheet';
      case AttachmentType.document:
        return 'Document';
      case AttachmentType.article:
        return 'Article';
      case AttachmentType.file:
        return 'File';
    }
  }
}

/// Attachment type enumeration
enum AttachmentType {
  file,
  document,
  article,
  image,
  video,
  audio,
  pdf,
  doc,
  xlsx,
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

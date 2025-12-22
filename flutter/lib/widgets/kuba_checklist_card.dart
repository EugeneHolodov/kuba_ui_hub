import 'package:flutter/material.dart';
import 'kuba_divider_titled.dart';
import 'kuba_tag.dart';
import 'kuba_attachment.dart';
import '../config/kuba_colors.dart';

/// Reusable Material 3 Checklist Card widget
///
/// Features:
/// - Title and subtitle
/// - Segmented control for status (ok, n/a, deviation)
/// - Expandable attachments section with required add button and swipeable delete
/// - Expandable comment input with badge
/// - Smooth animations for all expandable sections
class KubaChecklistCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final ChecklistStatus? status;
  final List<ChecklistAttachment> attachments;
  final String? comment;
  final ValueChanged<String?>? onCommentChanged;
  final ValueChanged<ChecklistStatus?>? onStatusChanged;
  final VoidCallback onAttachmentAdd;
  final ValueChanged<int>? onAttachmentRemove;
  final String? errorText;
  final String? userName;
  final DateTime? timestamp;

  const KubaChecklistCard({
    super.key,
    required this.title,
    this.subtitle,
    this.status,
    this.attachments = const [],
    this.comment,
    this.onCommentChanged,
    this.onStatusChanged,
    required this.onAttachmentAdd,
    this.onAttachmentRemove,
    this.errorText,
    this.userName,
    this.timestamp,
  });

  @override
  State<KubaChecklistCard> createState() => _KubaChecklistCardState();
}

enum ChecklistState { defaultState, attachmentsExpanded }

enum ChecklistStatus { ok, na, deviation }

class _KubaChecklistCardState extends State<KubaChecklistCard> {
  ChecklistState _currentState = ChecklistState.defaultState;
  bool _isCommentExpanded = false;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.comment ?? '');
  }

  @override
  void didUpdateWidget(KubaChecklistCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.comment != oldWidget.comment) {
      _commentController.text = widget.comment ?? '';
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleAttachments() {
    setState(() {
      if (_currentState == ChecklistState.attachmentsExpanded) {
        _currentState = ChecklistState.defaultState;
      } else {
        _currentState = ChecklistState.attachmentsExpanded;
      }
    });
  }

  void _toggleComment() {
    setState(() {
      _isCommentExpanded = !_isCommentExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title section with error indicator
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                if (widget.subtitle != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.subtitle!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: widget.errorText != null
                                ? Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: colorScheme.error,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.priority_high,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.status != null
                                ? Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: colorScheme.onPrimary,
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row with segmented control and comment button
                      Row(
                        children: [
                          // Segmented control for status
                          Flexible(
                            child: _buildStatusSegmentedControl(
                              context,
                              theme,
                              colorScheme,
                            ),
                          ),
                          // Comment icon with badge
                          if (widget.onCommentChanged != null) ...[
                            const SizedBox(width: 8),
                            _buildCommentButton(context, theme, colorScheme),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Comment input section (expandable)
                      // Animated comment section
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child:
                            widget.onCommentChanged != null &&
                                _isCommentExpanded
                            ? Column(
                                children: [
                                  TextField(
                                    controller: _commentController,
                                    onChanged: widget.onCommentChanged!,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      labelText: 'Comment',
                                      hintText: 'Enter your comment...',
                                      filled: true,
                                      fillColor: colorScheme.surface,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: colorScheme.outline,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: colorScheme.outline,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Animated signed by section (shown when status is selected)
                      AnimatedSize(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        child: widget.status != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KubaDividerTitled(
                                    title: 'signed by',
                                    variant: DividerVariant.left,
                                    spacing: 0,
                                  ),
                                  if (widget.userName != null ||
                                      widget.timestamp != null) ...[
                                    const SizedBox(height: 12),
                                    KubaTag(
                                      label: widget.userName,
                                      timestamp: widget.timestamp,
                                      icon: Icons.person,
                                      color: colorScheme.primary,
                                      onColor: colorScheme.primary,
                                    ),
                                  ],
                                  const SizedBox(height: 16),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Attachments section (expandable)
                      _buildAttachmentsSection(context, theme, colorScheme),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Error message container - seamless with card
          Container(
            height: 20,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 4),
            decoration: BoxDecoration(
              color: widget.errorText != null
                  ? colorScheme.error.withValues(alpha: 0.02)
                  : colorScheme.surface.withValues(alpha: 0.02),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.errorText ?? ' ',
              style: TextStyle(
                color: widget.errorText != null
                    ? colorScheme.error
                    : Colors.transparent,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSegmentedControl(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatusSegment(
            context,
            theme,
            colorScheme,
            ChecklistStatus.ok,
            'ok',
            null,
            widget.status == ChecklistStatus.ok,
          ),
          _buildStatusSegment(
            context,
            theme,
            colorScheme,
            ChecklistStatus.na,
            'n/a',
            null,
            widget.status == ChecklistStatus.na,
          ),
          _buildStatusSegment(
            context,
            theme,
            colorScheme,
            ChecklistStatus.deviation,
            'deviation',
            null,
            widget.status == ChecklistStatus.deviation,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSegment(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    ChecklistStatus status,
    String label,
    IconData? icon,
    bool isSelected,
  ) {
    // Get status-specific colors
    Color backgroundColor;
    Color textColor;

    if (isSelected) {
      switch (status) {
        case ChecklistStatus.ok:
          // Lime green - fresh and positive, complements purple
          backgroundColor = KubaColors.statusOk;
          textColor = Colors.black87;
          break;
        case ChecklistStatus.na:
          // Purple-blue - complements primary purple color
          backgroundColor = KubaColors.statusNA;
          textColor = Colors.black87;
          break;
        case ChecklistStatus.deviation:
          // Deep orange - warm, matches the orange secondary color
          backgroundColor = KubaColors.statusDeviation;
          textColor = Colors.black87;
          break;
      }
    } else {
      backgroundColor = KubaColors.transparent;
      textColor = colorScheme.onSurface;
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          if (widget.onStatusChanged != null) {
            // If already selected, deselect (set to null), otherwise select
            widget.onStatusChanged!(isSelected ? null : status);
          }
        },
        borderRadius: BorderRadius.only(
          topLeft: status == ChecklistStatus.ok
              ? const Radius.circular(12)
              : Radius.zero,
          bottomLeft: status == ChecklistStatus.ok
              ? const Radius.circular(12)
              : Radius.zero,
          topRight: status == ChecklistStatus.deviation
              ? const Radius.circular(12)
              : Radius.zero,
          bottomRight: status == ChecklistStatus.deviation
              ? const Radius.circular(12)
              : Radius.zero,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: status == ChecklistStatus.ok
                  ? const Radius.circular(12)
                  : Radius.zero,
              bottomLeft: status == ChecklistStatus.ok
                  ? const Radius.circular(12)
                  : Radius.zero,
              topRight: status == ChecklistStatus.deviation
                  ? const Radius.circular(12)
                  : Radius.zero,
              bottomRight: status == ChecklistStatus.deviation
                  ? const Radius.circular(12)
                  : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentButton(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(Icons.mode_comment_rounded, color: colorScheme.primary),
          onPressed: _toggleComment,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        if (widget.comment != null && widget.comment!.isNotEmpty)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  '1',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAttachmentsSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final isExpanded = _currentState == ChecklistState.attachmentsExpanded;
    final attachmentCount = widget.attachments.length;
    final hasAttachments = attachmentCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (hasAttachments)
              Expanded(
                child: InkWell(
                  onTap: _toggleAttachments,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: colorScheme.onPrimaryContainer,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '$attachmentCount attachments i total',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: colorScheme.onPrimaryContainer,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (!hasAttachments) const Spacer(),
            if (hasAttachments) const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: widget.onAttachmentAdd,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        // Animated attachments list
        AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          child: isExpanded && widget.attachments.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 12),
                    ...widget.attachments.asMap().entries.map((entry) {
                      final index = entry.key;
                      final attachment = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: KubaAttachment(
                          fileName: attachment.name,
                          type: _mapIconToAttachmentType(attachment.icon),
                          rightSwipeAction: widget.onAttachmentRemove != null
                              ? SwipeAction(
                                  label: 'Delete',
                                  icon: Icons.delete,
                                  backgroundColor: colorScheme.error,
                                  iconColor: colorScheme.onError,
                                  onAction: () =>
                                      widget.onAttachmentRemove!(index),
                                )
                              : null,
                        ),
                      );
                    }),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  AttachmentType _mapIconToAttachmentType(IconData? icon) {
    if (icon == null) return AttachmentType.file;

    // Map common icons to attachment types by comparing code points
    final iconCodePoint = icon.codePoint;

    if (iconCodePoint == Icons.image.codePoint ||
        iconCodePoint == Icons.image_outlined.codePoint) {
      return AttachmentType.image;
    } else if (iconCodePoint == Icons.video_file.codePoint ||
        iconCodePoint == Icons.video_library.codePoint) {
      return AttachmentType.video;
    } else if (iconCodePoint == Icons.audiotrack.codePoint ||
        iconCodePoint == Icons.audio_file.codePoint) {
      return AttachmentType.audio;
    } else if (iconCodePoint == Icons.picture_as_pdf.codePoint) {
      return AttachmentType.pdf;
    } else if (iconCodePoint == Icons.description.codePoint) {
      return AttachmentType.doc;
    } else if (iconCodePoint == Icons.table_chart.codePoint) {
      return AttachmentType.xlsx;
    } else if (iconCodePoint == Icons.article.codePoint) {
      return AttachmentType.article;
    } else if (iconCodePoint == Icons.insert_drive_file.codePoint) {
      return AttachmentType.document;
    } else {
      return AttachmentType.file;
    }
  }
}

/// Model for a status tag displayed in the top-right corner of the card
class StatusTag {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const StatusTag({
    required this.label,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });
}

/// Model for a checklist attachment
class ChecklistAttachment {
  final String name;
  final IconData? icon;

  const ChecklistAttachment({required this.name, this.icon});
}

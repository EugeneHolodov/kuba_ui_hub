import 'package:flutter/material.dart';

/// Reusable Material 3 Divider widget with tagged title
///
/// Features:
/// - Tagged title label for section separation
/// - Material 3 styling with brand colors
/// - Customizable spacing and styling
/// - Fully reusable and customizable
class KubaDividerTitled extends StatelessWidget {
  // Constants
  static const double _defaultSpacing = 24.0;
  static const double _defaultThickness = 1.0;
  static const double _tagPadding = 8.0;
  static const double _tagHeight = 24.0;

  final String title;
  final Color? dividerColor;
  final Color? tagBackgroundColor;
  final Color? tagTextColor;
  final double? spacing;
  final double? thickness;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final DividerVariant variant;

  const KubaDividerTitled({
    super.key,
    required this.title,
    this.dividerColor,
    this.tagBackgroundColor,
    this.tagTextColor,
    this.spacing,
    this.thickness,
    this.padding,
    this.titleStyle,
    this.variant = DividerVariant.centered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveSpacing = spacing ?? _defaultSpacing;
    final effectiveThickness = thickness ?? _defaultThickness;
    final effectivePadding = padding ?? EdgeInsets.zero;

    final effectiveDividerColor =
        dividerColor ?? theme.colorScheme.outline.withOpacity(0.3);
    final effectiveTagBackgroundColor =
        tagBackgroundColor ?? theme.colorScheme.primaryContainer;
    final effectiveTagTextColor =
        tagTextColor ?? theme.colorScheme.onPrimaryContainer;

    final TextStyle effectiveTitleStyle =
        titleStyle ??
        (theme.textTheme.labelSmall?.copyWith(
              color: effectiveTagTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ) ??
            TextStyle(
              color: effectiveTagTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ));

    // For fullWidth variant, don't constrain height as it needs more space
    final dividerWidget = _buildDivider(
      context,
      theme,
      effectiveDividerColor,
      effectiveTagBackgroundColor,
      effectiveTagTextColor,
      effectiveThickness,
      effectiveTitleStyle,
    );

    return Padding(
      padding: effectivePadding,
      child: variant == DividerVariant.fullWidth
          ? dividerWidget
          : effectiveSpacing == 0
          ? dividerWidget
          : SizedBox(height: effectiveSpacing, child: dividerWidget),
    );
  }

  Widget _buildDivider(
    BuildContext context,
    ThemeData theme,
    Color dividerColor,
    Color tagBackgroundColor,
    Color tagTextColor,
    double thickness,
    TextStyle titleStyle,
  ) {
    switch (variant) {
      case DividerVariant.centered:
        return _buildCenteredDivider(
          dividerColor,
          tagBackgroundColor,
          tagTextColor,
          thickness,
          titleStyle,
        );
      case DividerVariant.left:
        return _buildLeftDivider(
          dividerColor,
          tagBackgroundColor,
          tagTextColor,
          thickness,
          titleStyle,
        );
      case DividerVariant.right:
        return _buildRightDivider(
          dividerColor,
          tagBackgroundColor,
          tagTextColor,
          thickness,
          titleStyle,
        );
      case DividerVariant.fullWidth:
        return _buildFullWidthDivider(
          dividerColor,
          tagBackgroundColor,
          tagTextColor,
          thickness,
          titleStyle,
        );
    }
  }

  Widget _buildCenteredDivider(
    Color dividerColor,
    Color tagBackgroundColor,
    Color tagTextColor,
    double thickness,
    TextStyle titleStyle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(thickness: thickness, color: dividerColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _tagPadding,
                vertical: 4.0,
              ),
              constraints: const BoxConstraints(
                minHeight: _tagHeight,
                minWidth: 32.0,
              ),
              decoration: BoxDecoration(
                color: tagBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                title.isNotEmpty ? title : 'or',
                style: TextStyle(
                  color: tagTextColor,
                  fontSize: titleStyle.fontSize ?? 12.0,
                  fontWeight: titleStyle.fontWeight ?? FontWeight.w600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(thickness: thickness, color: dividerColor),
        ),
      ],
    );
  }

  Widget _buildLeftDivider(
    Color dividerColor,
    Color tagBackgroundColor,
    Color tagTextColor,
    double thickness,
    TextStyle titleStyle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _tagPadding,
            vertical: 4.0,
          ),
          constraints: const BoxConstraints(minHeight: _tagHeight),
          decoration: BoxDecoration(
            color: tagBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: titleStyle.copyWith(color: tagTextColor)),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Divider(thickness: thickness, color: dividerColor),
        ),
      ],
    );
  }

  Widget _buildRightDivider(
    Color dividerColor,
    Color tagBackgroundColor,
    Color tagTextColor,
    double thickness,
    TextStyle titleStyle,
  ) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: thickness, color: dividerColor),
        ),
        const SizedBox(width: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _tagPadding,
            vertical: 4.0,
          ),
          constraints: const BoxConstraints(minHeight: _tagHeight),
          decoration: BoxDecoration(
            color: tagBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: titleStyle.copyWith(color: tagTextColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildFullWidthDivider(
    Color dividerColor,
    Color tagBackgroundColor,
    Color tagTextColor,
    double thickness,
    TextStyle titleStyle,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _tagPadding,
            vertical: 4.0,
          ),
          constraints: const BoxConstraints(minHeight: _tagHeight),
          decoration: BoxDecoration(
            color: tagBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: titleStyle.copyWith(color: tagTextColor)),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

/// Divider variant enumeration
enum DividerVariant {
  /// Tag centered between two divider lines
  centered,

  /// Tag on the left, divider extends to the right
  left,

  /// Tag on the right, divider extends to the left
  right,

  /// Tag above a full-width divider
  fullWidth,
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

/// Reusable Material 3 App Bar widget with brand styling
///
/// Features:
/// - Dark purple background matching brand colors
/// - Optional flag icon on the left
/// - Optional back button
/// - Centered title
/// - Optional hamburger menu on the right
/// - Status bar styling
class KubaAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Constants
  static const double _sidePadding = 16.0;
  static const double _leadingContentWidth =
      80.0; // Increased to accommodate larger flag
  static const double _leadingTotalWidth = _sidePadding + _leadingContentWidth;
  static const double _flagWidth = 36.0;
  static const double _flagHeight = 27.0;
  static const double _flagBackGap = 4.0;
  static const double _minTouchTarget = 34.0;
  static const double _backButtonTouchTarget =
      44.0; // Larger touch target for back button
  static const double _iconSize = 26.0;
  static const double _rightPadding = 8.0;
  static const double _bottomPadding = 6.0;

  final String title;
  final String? subtitle;
  final Widget? leadingFlag;
  final VoidCallback? onFlagPressed;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;

  const KubaAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingFlag,
    this.onFlagPressed,
    this.showBackButton = false,
    this.onBackPressed,
    this.showMenuButton = false,
    this.onMenuPressed,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;
    final effectiveForegroundColor =
        foregroundColor ?? theme.colorScheme.onPrimary;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: effectiveBackgroundColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AppBar(
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        elevation: 0,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: _leadingTotalWidth,
        title: _buildTitle(context, effectiveForegroundColor),
        leading: _buildLeading(context, effectiveForegroundColor),
        actions: _buildActions(context, effectiveForegroundColor),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(_bottomPadding),
          child: const SizedBox(height: _bottomPadding),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Color textColor) {
    final theme = Theme.of(context);

    if (subtitle != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: textColor.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context, Color iconColor) {
    if (!showBackButton && leadingFlag == null) {
      return null;
    }

    final leftPadding = Padding(
      padding: const EdgeInsets.only(left: _sidePadding),
      child: _buildLeadingContent(context, iconColor),
    );

    return leftPadding;
  }

  Widget _buildLeadingContent(BuildContext context, Color iconColor) {
    // Only back button
    if (showBackButton && leadingFlag == null) {
      return _buildBackButton(context, iconColor);
    }

    // Only flag
    if (leadingFlag != null && !showBackButton) {
      return _buildFlagButton(context);
    }

    // Both flag and back button
    return SizedBox(
      width: _leadingContentWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildFlagButton(context),
          const SizedBox(width: _flagBackGap),
          Flexible(child: _buildBackButton(context, iconColor)),
        ],
      ),
    );
  }

  Widget _buildFlagButton(BuildContext context) {
    if (leadingFlag == null) {
      return const SizedBox.shrink();
    }

    return IconButton(
      onPressed: onFlagPressed,
      constraints: const BoxConstraints(
        minWidth: _minTouchTarget,
        minHeight: _minTouchTarget,
      ),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(shape: const CircleBorder()),
      icon: SizedBox(
        width: _flagWidth,
        height: _flagHeight,
        child: FittedBox(fit: BoxFit.contain, child: leadingFlag!),
      ),
      tooltip: 'Flag',
    );
  }

  Widget _buildBackButton(BuildContext context, Color iconColor) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: iconColor,
      iconSize: _iconSize,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: _backButtonTouchTarget,
        minHeight: _backButtonTouchTarget,
      ),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      tooltip: 'Back',
    );
  }

  List<Widget>? _buildActions(BuildContext context, Color iconColor) {
    final actionWidgets = <Widget>[];

    if (actions != null) {
      actionWidgets.addAll(actions!);
    }

    if (showMenuButton) {
      actionWidgets.add(_buildMenuButton(context, iconColor));
    }

    if (actionWidgets.isEmpty) {
      return null;
    }

    // Add right side padding
    actionWidgets.add(const SizedBox(width: _rightPadding));

    return actionWidgets;
  }

  Widget _buildMenuButton(BuildContext context, Color iconColor) {
    return IconButton(
      icon: const Icon(Icons.menu),
      color: iconColor,
      iconSize: _minTouchTarget,
      constraints: const BoxConstraints(
        minWidth: _minTouchTarget,
        minHeight: _minTouchTarget,
      ),
      onPressed: onMenuPressed ?? () => Scaffold.of(context).openEndDrawer(),
      tooltip: 'Menu',
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + _bottomPadding);
}

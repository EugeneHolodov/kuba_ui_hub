import 'package:flutter/material.dart';

enum KubaButtonMode { primary, secondary, transparent, outlined, text, danger }

enum KubaButtonSize { small, medium, large }

class KubaButtonSecondVersion extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final bool disabled;
  final KubaButtonMode mode;
  final KubaButtonSize size;
  final VoidCallback? onPressed;
  final Color? accentColor;
  final Color? onAccentColor;
  final bool scale;

  const KubaButtonSecondVersion({
    super.key,
    required this.text,
    this.prefixIcon,
    this.disabled = false,
    this.mode = KubaButtonMode.primary,
    this.size = KubaButtonSize.medium,
    this.onPressed,
    this.accentColor,
    this.onAccentColor,
    this.scale = false,
  });

  bool get _isEnabled => !disabled && onPressed != null;

  double _getHeight() {
    switch (size) {
      case KubaButtonSize.small:
        return 40;
      case KubaButtonSize.medium:
        return 52;
      case KubaButtonSize.large:
        return 64;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case KubaButtonSize.small:
        return 20;
      case KubaButtonSize.medium:
        return 28;
      case KubaButtonSize.large:
        return 36;
    }
  }

  double _getIconSize() {
    switch (size) {
      case KubaButtonSize.small:
        return 18;
      case KubaButtonSize.medium:
        return 22;
      case KubaButtonSize.large:
        return 26;
    }
  }

  double _getFontSize() {
    switch (size) {
      case KubaButtonSize.small:
        return 15;
      case KubaButtonSize.medium:
        return 17;
      case KubaButtonSize.large:
        return 19;
    }
  }

  double _getBorderRadius() {
    // More rounded, pill-like shape
    switch (size) {
      case KubaButtonSize.small:
        return 20;
      case KubaButtonSize.medium:
        return 26;
      case KubaButtonSize.large:
        return 32;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (mode) {
      case KubaButtonMode.primary:
        return accentColor ?? Theme.of(context).colorScheme.primary;
      case KubaButtonMode.secondary:
        return accentColor ?? Theme.of(context).colorScheme.secondary;
      case KubaButtonMode.danger:
        return Theme.of(context).colorScheme.error;
      case KubaButtonMode.transparent:
      case KubaButtonMode.outlined:
      case KubaButtonMode.text:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (mode) {
      case KubaButtonMode.primary:
        return onAccentColor ?? Theme.of(context).colorScheme.onPrimary;
      case KubaButtonMode.secondary:
        return onAccentColor ?? Theme.of(context).colorScheme.onSecondary;
      case KubaButtonMode.danger:
        return Theme.of(context).colorScheme.onError;
      case KubaButtonMode.transparent:
      case KubaButtonMode.outlined:
        return accentColor ?? Theme.of(context).colorScheme.primary;
      case KubaButtonMode.text:
        return accentColor ?? Theme.of(context).colorScheme.primary;
    }
  }

  Color? _getBorderColor(BuildContext context) {
    switch (mode) {
      case KubaButtonMode.primary:
      case KubaButtonMode.secondary:
      case KubaButtonMode.danger:
      case KubaButtonMode.text:
        return null;
      case KubaButtonMode.transparent:
      case KubaButtonMode.outlined:
        return accentColor ?? Theme.of(context).colorScheme.primary;
    }
  }

  List<BoxShadow>? _getBoxShadow(BuildContext context) {
    // Softer, more diffused shadows
    switch (mode) {
      case KubaButtonMode.primary:
      case KubaButtonMode.secondary:
      case KubaButtonMode.danger:
        final color = mode == KubaButtonMode.danger
            ? Theme.of(context).colorScheme.error
            : (accentColor ?? Theme.of(context).colorScheme.primary);
        return [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ];
      case KubaButtonMode.transparent:
      case KubaButtonMode.outlined:
      case KubaButtonMode.text:
        return null;
    }
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    final backgroundColor = _getBackgroundColor(context);
    final foregroundColor = _getForegroundColor(context);
    final height = _getHeight();
    final horizontalPadding = _getHorizontalPadding();
    final fontSize = _getFontSize();
    final borderRadius = _getBorderRadius();

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          if (mode == KubaButtonMode.primary ||
              mode == KubaButtonMode.secondary ||
              mode == KubaButtonMode.danger) {
            return Colors.grey.shade100;
          }
          return Colors.transparent;
        }
        if (mode == KubaButtonMode.transparent ||
            mode == KubaButtonMode.outlined ||
            mode == KubaButtonMode.text) {
          return Colors.transparent;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade600;
        }
        return foregroundColor;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: Colors.grey.shade600, width: 1.5);
        }
        final border = _getBorderColor(context);
        if (border != null) {
          return BorderSide(color: border, width: 2.0);
        }
        return null;
      }),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: horizontalPadding),
      ),
      minimumSize: WidgetStateProperty.all(Size(0, height)),
      fixedSize: scale
          ? WidgetStateProperty.all(Size(double.infinity, height))
          : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      elevation: WidgetStateProperty.all(0), // We use custom shadow
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500, // Slightly lighter weight
          letterSpacing: 0.8, // More letter spacing for modern look
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        // Subtle overlay on press
        if (states.contains(WidgetState.pressed)) {
          return Colors.black.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.black.withOpacity(0.05);
        }
        return null;
      }),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final iconSize = _getIconSize();
    final iconColor = _isEnabled
        ? _getForegroundColor(context)
        : Colors.grey.shade600;

    return Row(
      mainAxisSize: scale ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: iconSize, color: iconColor),
          SizedBox(width: size == KubaButtonSize.small ? 8 : 10),
        ],
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final boxShadow = _getBoxShadow(context);
    final buttonStyle = _buildButtonStyle(context);

    Widget button;

    // Use appropriate Material 3 button widget based on mode
    switch (mode) {
      case KubaButtonMode.primary:
      case KubaButtonMode.secondary:
      case KubaButtonMode.danger:
        button = FilledButton(
          onPressed: _isEnabled ? onPressed : null,
          style: buttonStyle,
          child: _buildButtonContent(context),
        );
        break;
      case KubaButtonMode.outlined:
      case KubaButtonMode.transparent:
        button = OutlinedButton(
          onPressed: _isEnabled ? onPressed : null,
          style: buttonStyle,
          child: _buildButtonContent(context),
        );
        break;
      case KubaButtonMode.text:
        button = TextButton(
          onPressed: _isEnabled ? onPressed : null,
          style: buttonStyle,
          child: _buildButtonContent(context),
        );
        break;
    }

    // Wrap with shadow container for filled buttons
    if (boxShadow != null) {
      button = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          boxShadow: boxShadow,
        ),
        child: button,
      );
    }

    // If scale is true, wrap in SizedBox with full width
    if (scale && boxShadow == null) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}

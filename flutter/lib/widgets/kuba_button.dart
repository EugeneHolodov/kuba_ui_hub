import 'package:flutter/material.dart';

enum KubaButtonMode { primary, secondary, transparent, outlined, text, danger }

enum KubaButtonSize { small, medium, large }

class KubaButton extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final bool disabled;
  final KubaButtonMode mode;
  final KubaButtonSize size;
  final VoidCallback? onPressed;
  final Color? accentColor;
  final Color? onAccentColor;
  final bool scale;

  const KubaButton({
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
        return 36;
      case KubaButtonSize.medium:
        return 48;
      case KubaButtonSize.large:
        return 56;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case KubaButtonSize.small:
        return 16;
      case KubaButtonSize.medium:
        return 24;
      case KubaButtonSize.large:
        return 32;
    }
  }

  double _getIconSize() {
    switch (size) {
      case KubaButtonSize.small:
        return 16;
      case KubaButtonSize.medium:
        return 20;
      case KubaButtonSize.large:
        return 24;
    }
  }

  double _getFontSize() {
    switch (size) {
      case KubaButtonSize.small:
        return 14;
      case KubaButtonSize.medium:
        return 16;
      case KubaButtonSize.large:
        return 18;
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
    // Only add shadow for filled buttons
    switch (mode) {
      case KubaButtonMode.primary:
      case KubaButtonMode.secondary:
      case KubaButtonMode.danger:
        final color = mode == KubaButtonMode.danger
            ? Theme.of(context).colorScheme.error
            : (accentColor ?? Theme.of(context).colorScheme.primary);
        return [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
    final boxShadow = _getBoxShadow(context);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          // Lighter, more subtle gray for disabled filled buttons
          if (mode == KubaButtonMode.primary ||
              mode == KubaButtonMode.secondary ||
              mode == KubaButtonMode.danger) {
            return Colors.grey.shade100;
          }
          // Keep transparent for outlined/text buttons
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
          // Lighter gray for disabled text/icons
          return Colors.grey.shade600;
        }
        return foregroundColor;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          // Lighter border for disabled outlined buttons
          return BorderSide(color: Colors.grey.shade600, width: 1.5);
        }
        final border = _getBorderColor(context);
        if (border != null) {
          return BorderSide(color: border, width: 1.5);
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
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled) || boxShadow == null) {
          return 0;
        }
        return 0; // We'll use Container shadow instead
      }),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final iconSize = _getIconSize();
    // Icon color will be handled by the button's foregroundColor style
    // Use lighter gray for disabled state to match the text color
    final iconColor = _isEnabled
        ? _getForegroundColor(context)
        : Colors.grey.shade400;

    return Row(
      mainAxisSize: scale ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: iconSize, color: iconColor),
          SizedBox(width: size == KubaButtonSize.small ? 6 : 8),
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
          borderRadius: BorderRadius.circular(16),
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

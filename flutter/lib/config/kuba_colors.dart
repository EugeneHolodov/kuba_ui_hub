import 'package:flutter/material.dart';

/// Centralized color configuration for the entire application
/// 
/// This file contains all color definitions used throughout the app.
/// Easy to switch for white-labeling or theme changes.
/// 
/// Usage:
/// - Use KubaColors.primary instead of hardcoded colors
/// - Create different color sets for different brands/themes
/// - Switch between color sets by changing the active configuration
class KubaColors {
  // Prevent instantiation
  KubaColors._();

  // ============================================================================
  // BRAND COLORS - Primary Brand Identity
  // ============================================================================
  
  /// Primary brand color (Purple)
  static const Color primary = Color(0xFF93328E);
  
  /// Primary tint (lighter purple)
  static const Color primaryTint = Color(0xFF9E4799);
  
  /// Secondary brand color (Orange/Amber)
  static const Color secondary = Color(0xFFF1B434);
  
  /// Secondary tint (lighter orange)
  static const Color secondaryTint = Color(0xFFF2BC48);

  // ============================================================================
  // STATUS COLORS - For checklist and status indicators
  // ============================================================================
  
  /// Success/OK status color (Lime green)
  static final Color statusOk = Colors.lightGreen.shade300;
  
  /// Not Applicable status color (Purple-blue)
  static final Color statusNA = Colors.indigo.shade200;
  
  /// Deviation/Warning status color (Deep orange)
  static final Color statusDeviation = Colors.deepOrange.shade200;
  
  /// Error color
  static const Color error = Colors.red;
  
  /// Success color (darker green for other contexts)
  static final Color success = Colors.green.shade600;
  
  /// Warning color (for warnings, not deviations)
  static final Color warning = Colors.orange.shade600;
  
  /// Info color
  static final Color info = Colors.blue.shade600;

  // ============================================================================
  // SURFACE COLORS - Backgrounds and containers
  // ============================================================================
  
  /// Main surface/background color
  static const Color surface = Colors.white;
  
  /// Surface container highest (lighter gray)
  static final Color surfaceContainerHighest = Colors.grey.shade100;
  
  /// Surface container high
  static final Color surfaceContainerHigh = Colors.grey.shade50;
  
  /// Surface variant
  static final Color surfaceVariant = Colors.grey.shade200;

  // ============================================================================
  // TEXT COLORS - For text content
  // ============================================================================
  
  /// Primary text color
  static const Color onSurface = Colors.black87;
  
  /// Secondary/variant text color
  static const Color onSurfaceVariant = Colors.black87;
  
  /// Text on primary color
  static const Color onPrimary = Colors.white;
  
  /// Text on secondary color
  static const Color onSecondary = Colors.black87;
  
  /// Text on error color
  static const Color onError = Colors.white;
  
  /// Disabled text color
  static final Color textDisabled = Colors.grey.shade400;
  
  /// Text dark (for emphasis)
  static final Color textDark = Colors.grey.shade800;

  // ============================================================================
  // BORDER & OUTLINE COLORS
  // ============================================================================
  
  /// Main outline/border color
  static final Color outline = Colors.grey.shade400;
  
  /// Outline variant (lighter)
  static final Color outlineVariant = Colors.grey.shade300;
  
  /// Divider color
  static final Color divider = Colors.grey.shade300;

  // ============================================================================
  // SHADOW COLORS
  // ============================================================================
  
  /// Shadow color
  static const Color shadow = Colors.black26;
  
  /// Primary shadow (with brand color tint)
  static Color get primaryShadow => primary.withValues(alpha: 0.15);

  // ============================================================================
  // CHART COLORS - For data visualization
  // ============================================================================
  
  /// Chart color 1 (Primary)
  static const Color chart1 = primary;
  
  /// Chart color 2 (Secondary)
  static const Color chart2 = secondary;
  
  /// Chart color 3 (Tertiary - teal/cyan)
  static final Color chart3 = Colors.teal.shade400;
  
  /// Chart color 4 (Quaternary - pink)
  static final Color chart4 = Colors.pink.shade300;
  
  /// Chart color 5 (Additional - blue)
  static final Color chart5 = Colors.blue.shade400;
  
  /// Chart color 6 (Additional - green)
  static final Color chart6 = Colors.green.shade400;

  // ============================================================================
  // INTERACTIVE ELEMENT COLORS
  // ============================================================================
  
  /// Hover state color (light overlay)
  static Color get hoverOverlay => Colors.black.withValues(alpha: 0.04);
  
  /// Pressed state color (light overlay)
  static Color get pressedOverlay => Colors.black.withValues(alpha: 0.08);
  
  /// Focus state color
  static Color get focusOverlay => primary.withValues(alpha: 0.12);
  
  /// Selected state color
  static Color get selectedOverlay => primary.withValues(alpha: 0.12);

  // ============================================================================
  // SPECIAL USE COLORS
  // ============================================================================
  
  /// Transparent
  static const Color transparent = Colors.transparent;
  
  /// Black overlay (for modals, sheets)
  static Color get blackOverlay => Colors.black.withValues(alpha: 0.5);
  
  /// White overlay
  static Color get whiteOverlay => Colors.white.withValues(alpha: 0.9);

  // ============================================================================
  // GRADIENT DEFINITIONS
  // ============================================================================
  
  /// Primary gradient (purple)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryTint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Secondary gradient (orange)
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryTint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Success gradient (green)
  static LinearGradient successGradient = LinearGradient(
    colors: [Colors.green.shade400, Colors.green.shade600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ============================================================================
// ALTERNATIVE COLOR SCHEMES - For White-Labeling
// ============================================================================

/// Alternative color scheme 1 - Blue theme
class KubaColorsBlue {
  KubaColorsBlue._();
  
  static const Color primary = Color(0xFF1976D2); // Blue
  static const Color primaryTint = Color(0xFF2196F3); // Light Blue
  static const Color secondary = Color(0xFFFF9800); // Orange
  static const Color secondaryTint = Color(0xFFFFA726); // Light Orange
  
  // Add other colors as needed following the same pattern as KubaColors
}

/// Alternative color scheme 2 - Green theme
class KubaColorsGreen {
  KubaColorsGreen._();
  
  static const Color primary = Color(0xFF388E3C); // Green
  static const Color primaryTint = Color(0xFF4CAF50); // Light Green
  static const Color secondary = Color(0xFFFF5722); // Deep Orange
  static const Color secondaryTint = Color(0xFFFF7043); // Light Deep Orange
  
  // Add other colors as needed following the same pattern as KubaColors
}

/// Alternative color scheme 3 - Red theme
class KubaColorsRed {
  KubaColorsRed._();
  
  static const Color primary = Color(0xFFD32F2F); // Red
  static const Color primaryTint = Color(0xFFE57373); // Light Red
  static const Color secondary = Color(0xFF1976D2); // Blue
  static const Color secondaryTint = Color(0xFF42A5F5); // Light Blue
  
  // Add other colors as needed following the same pattern as KubaColors
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/// Helper class for color utilities
class KubaColorUtils {
  KubaColorUtils._();
  
  /// Convert hex string to Color
  /// Example: "#FF93328E" or "93328E"
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  
  /// Convert Color to hex string
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
  
  /// Create a lighter version of a color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  /// Create a darker version of a color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}


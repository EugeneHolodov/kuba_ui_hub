import 'package:flutter/material.dart';
import 'kuba_colors.dart';

/// Centralized theme configuration for the entire application
/// 
/// This file creates ThemeData objects using colors from KubaColors.
/// Easy to switch themes or create white-label versions.
/// 
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: KubaTheme.lightTheme,
///   darkTheme: KubaTheme.darkTheme,
///   themeMode: ThemeMode.system,
///   ...
/// )
/// ```
class KubaTheme {
  // Prevent instantiation
  KubaTheme._();

  // ============================================================================
  // LIGHT THEME (Default)
  // ============================================================================
  
  static ThemeData get lightTheme {
    return ThemeData(
      // Material 3 design system
      useMaterial3: true,
      
      // Font family
      fontFamily: 'Helvetica',
      
      // Color scheme
      colorScheme: lightColorScheme,
      
      // App Bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: KubaColors.surface,
        foregroundColor: KubaColors.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: KubaColors.onSurface,
          fontFamily: 'Helvetica',
        ),
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: KubaColors.surface,
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KubaColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: KubaColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: KubaColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KubaColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KubaColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KubaColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KubaColors.primary,
          foregroundColor: KubaColors.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      
      // Filled button theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KubaColors.primary,
          foregroundColor: KubaColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      
      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: KubaColors.primary,
          side: const BorderSide(color: KubaColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: KubaColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // Icon button theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: KubaColors.primary,
        ),
      ),
      
      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: KubaColors.primary,
        foregroundColor: KubaColors.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: KubaColors.surfaceContainerHighest,
        deleteIconColor: KubaColors.onSurface,
        labelStyle: const TextStyle(
          color: KubaColors.onSurface,
          fontFamily: 'Helvetica',
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        backgroundColor: KubaColors.surface,
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: KubaColors.surface,
        elevation: 8,
      ),
      
      // Divider theme
      dividerTheme: DividerThemeData(
        color: KubaColors.divider,
        thickness: 1,
        space: 1,
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KubaColors.onPrimary;
          }
          return KubaColors.surfaceContainerHighest;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KubaColors.primary;
          }
          return KubaColors.outline;
        }),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KubaColors.primary;
          }
          return KubaColors.transparent;
        }),
        checkColor: WidgetStateProperty.all(KubaColors.onPrimary),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KubaColors.primary;
          }
          return KubaColors.outline;
        }),
      ),
      
      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: KubaColors.primary,
        inactiveTrackColor: KubaColors.surfaceContainerHighest,
        thumbColor: KubaColors.primary,
        overlayColor: KubaColors.focusOverlay,
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: KubaColors.primary,
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: KubaColors.onSurface,
        contentTextStyle: const TextStyle(color: KubaColors.surface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================================
  // LIGHT COLOR SCHEME
  // ============================================================================
  
  static ColorScheme get lightColorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      
      // Primary colors
      primary: KubaColors.primary,
      onPrimary: KubaColors.onPrimary,
      primaryContainer: KubaColors.primaryTint,
      onPrimaryContainer: KubaColors.onPrimary,
      
      // Secondary colors
      secondary: KubaColors.secondary,
      onSecondary: KubaColors.onSecondary,
      secondaryContainer: KubaColors.secondaryTint,
      onSecondaryContainer: KubaColors.onSecondary,
      
      // Error colors
      error: KubaColors.error,
      onError: KubaColors.onError,
      errorContainer: Colors.red.shade100,
      onErrorContainer: Colors.red.shade900,
      
      // Surface colors
      surface: KubaColors.surface,
      onSurface: KubaColors.onSurface,
      surfaceContainerHighest: KubaColors.surfaceContainerHighest,
      onSurfaceVariant: KubaColors.onSurfaceVariant,
      
      // Outline colors
      outline: KubaColors.outline,
      outlineVariant: KubaColors.outlineVariant,
      
      // Shadow
      shadow: KubaColors.shadow,
      
      // Surface tint
      surfaceTint: KubaColors.primary,
    );
  }

  // ============================================================================
  // DARK THEME (Optional - for future use)
  // ============================================================================
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Helvetica',
      colorScheme: darkColorScheme,
      // Add dark theme specific configurations
    );
  }
  
  static ColorScheme get darkColorScheme {
    return ColorScheme(
      brightness: Brightness.dark,
      
      // Primary colors
      primary: KubaColors.primaryTint,
      onPrimary: Colors.black,
      primaryContainer: KubaColors.primary,
      onPrimaryContainer: Colors.white,
      
      // Secondary colors
      secondary: KubaColors.secondaryTint,
      onSecondary: Colors.black,
      secondaryContainer: KubaColors.secondary,
      onSecondaryContainer: Colors.black,
      
      // Error colors
      error: Colors.red.shade300,
      onError: Colors.black,
      errorContainer: Colors.red.shade900,
      onErrorContainer: Colors.red.shade200,
      
      // Surface colors
      surface: Colors.grey.shade900,
      onSurface: Colors.white,
      surfaceContainerHighest: Colors.grey.shade800,
      onSurfaceVariant: Colors.white70,
      
      // Outline colors
      outline: Colors.grey.shade600,
      outlineVariant: Colors.grey.shade700,
      
      // Shadow
      shadow: Colors.black54,
      
      // Surface tint
      surfaceTint: KubaColors.primaryTint,
    );
  }

  // ============================================================================
  // ALTERNATIVE THEMES - For White-Labeling
  // ============================================================================
  
  /// Blue theme (example)
  static ThemeData get blueTheme {
    return lightTheme.copyWith(
      colorScheme: lightColorScheme.copyWith(
        primary: KubaColorsBlue.primary,
        primaryContainer: KubaColorsBlue.primaryTint,
        secondary: KubaColorsBlue.secondary,
        secondaryContainer: KubaColorsBlue.secondaryTint,
      ),
    );
  }
  
  /// Green theme (example)
  static ThemeData get greenTheme {
    return lightTheme.copyWith(
      colorScheme: lightColorScheme.copyWith(
        primary: KubaColorsGreen.primary,
        primaryContainer: KubaColorsGreen.primaryTint,
        secondary: KubaColorsGreen.secondary,
        secondaryContainer: KubaColorsGreen.secondaryTint,
      ),
    );
  }
  
  /// Red theme (example)
  static ThemeData get redTheme {
    return lightTheme.copyWith(
      colorScheme: lightColorScheme.copyWith(
        primary: KubaColorsRed.primary,
        primaryContainer: KubaColorsRed.primaryTint,
        secondary: KubaColorsRed.secondary,
        secondaryContainer: KubaColorsRed.secondaryTint,
      ),
    );
  }
}

// ============================================================================
// THEME MODE MANAGER (Optional - for runtime theme switching)
// ============================================================================

/// Manager for runtime theme switching
class KubaThemeManager extends ChangeNotifier {
  ThemeData _currentTheme = KubaTheme.lightTheme;
  
  ThemeData get currentTheme => _currentTheme;
  
  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
  
  void setLightTheme() {
    _currentTheme = KubaTheme.lightTheme;
    notifyListeners();
  }
  
  void setDarkTheme() {
    _currentTheme = KubaTheme.darkTheme;
    notifyListeners();
  }
  
  void setBlueTheme() {
    _currentTheme = KubaTheme.blueTheme;
    notifyListeners();
  }
  
  void setGreenTheme() {
    _currentTheme = KubaTheme.greenTheme;
    notifyListeners();
  }
  
  void setRedTheme() {
    _currentTheme = KubaTheme.redTheme;
    notifyListeners();
  }
}


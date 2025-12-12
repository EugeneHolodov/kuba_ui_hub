# Reserved Space Pattern for Validation Messages

## Overview

This document describes the pattern for reserving space for validation messages in Kuba UI widgets to prevent layout shifts when error messages appear or disappear.

## The Problem

When a TextField displays an `errorText`, it adds extra vertical space below the input field to show the error message. If this space is not reserved when there's no error, the entire page layout will jump when validation errors appear or disappear, creating a poor user experience.

## The Solution

Always reserve space for the validation message area by using `helperText` when there's no `errorText`.

### Implementation Pattern

```dart
decoration: InputDecoration(
  labelText: 'Your Label',
  hintText: 'Your hint',
  filled: true,
  fillColor: Theme.of(context).colorScheme.surface,
  errorText: widget.errorText,
  // Always reserve space for validation message
  helperText: widget.errorText == null ? ' ' : null,
  helperMaxLines: 1,
  // ... other decoration properties
),
```

### How It Works

1. **When `errorText` is null**: The `helperText` shows a single space character `' '`, which reserves the vertical space without displaying anything visible.

2. **When `errorText` is set**: The `helperText` is `null`, so the TextField uses the reserved space to display the error message.

3. **Result**: The space below the TextField is always the same height, preventing layout shifts.

## Validation Icon Alignment

When using validation icons (check or error icons) next to the input field, you need to adjust their vertical position to account for the reserved space:

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: TextField(...), // Your input field with reserved space
    ),
    AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: showStatusIcon
          ? Padding(
              padding: const EdgeInsets.only(bottom: 20), // Offset for reserved space
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  _buildStatusIcon(hasValue, isValid),
                ],
              ),
            )
          : const SizedBox.shrink(),
    ),
  ],
)
```

The `bottom: 20` padding offsets the icon upward to align with the center of the visible input field, compensating for the reserved helper text space.

## Widgets Using This Pattern

The following Kuba UI widgets implement this pattern:

- `kuba_input.dart` - Standard input field
- `kuba_input_variant2.dart` - Compact input field with right-side icon
- `kuba_number_input.dart` - Number input with +1/-1 buttons
- `kuba_dropdown_variant3.dart` - Dropdown with bottom sheet selector

## Best Practices

1. **Always implement this pattern** for any new input widget that supports error validation.

2. **Keep the helperMaxLines to 1** to maintain consistent spacing.

3. **Use a single space character `' '`** for helperText, not an empty string `''` (empty strings don't reserve space).

4. **Adjust icon positioning** if you have validation icons next to the input field.

5. **Test the widget** with and without error messages to ensure the layout remains stable.

## Example: Adding to a New Widget

```dart
class MyNewInputWidget extends StatefulWidget {
  final String? errorText;
  // ... other properties

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'My Input',
        errorText: widget.errorText,
        // Add these two lines to reserve space:
        helperText: widget.errorText == null ? ' ' : null,
        helperMaxLines: 1,
        // ... other properties
      ),
    );
  }
}
```

## Testing

To verify the pattern is working correctly:

1. Create a widget with the input field
2. Add a toggle to show/hide the error message
3. Observe that content below the input field does not move when toggling the error
4. The space below should remain constant

## Additional Notes

- This pattern works for all Material 3 TextField widgets
- The reserved space height is approximately 16-20px depending on the theme
- This is a standard UX practice to prevent "layout thrashing" or "content jumping"
- Users appreciate stable layouts that don't shift unexpectedly

---

**Last Updated**: December 2024  
**Pattern Implemented By**: Kuba UI Hub Team

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable Material 3 number input widget with increment/decrement buttons.
///
/// Features:
/// - +1/-1 buttons for quick value adjustment
/// - Validation icon (check when valid, error when invalid)
/// - Material 3 design with brand colors
/// - Support for min/max values
/// - Customizable step size
///
/// Example:
/// ```dart
/// KubaNumberInput(
///   value: _numberValue,
///   onChanged: (value) => setState(() => _numberValue = value),
///   labelText: 'Quantity',
///   hintText: 'Enter number',
///   accentColor: Theme.of(context).colorScheme.primary,
///   onAccentColor: Theme.of(context).colorScheme.onPrimary,
///   min: 0,
///   max: 100,
///   step: 1,
/// )
/// ```
class KubaNumberInput extends StatefulWidget {
  final int? value;
  final ValueChanged<int?> onChanged;
  final String labelText;
  final String hintText;
  final Color accentColor;
  final Color onAccentColor;
  final String? errorText;
  final int? min;
  final int? max;
  final int step;
  final bool enabled;

  const KubaNumberInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Number',
    this.hintText = 'Enter number',
    required this.accentColor,
    required this.onAccentColor,
    this.errorText,
    this.min,
    this.max,
    this.step = 1,
    this.enabled = true,
  });

  @override
  State<KubaNumberInput> createState() => _KubaNumberInputState();
}

class _KubaNumberInputState extends State<KubaNumberInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString() ?? '');
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(KubaNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      final newValue = widget.value?.toString() ?? '';
      if (_controller.text != newValue) {
        _controller.text = newValue;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _hasValue() {
    return widget.value != null;
  }

  bool _isValid() {
    if (widget.errorText != null) return false;
    if (widget.value == null) return false;
    if (widget.min != null && widget.value! < widget.min!) return false;
    if (widget.max != null && widget.value! > widget.max!) return false;
    return true;
  }

  void _increment() {
    if (!widget.enabled) return;
    final currentValue = widget.value ?? (widget.min ?? 0);
    final newValue = currentValue + widget.step;
    final clampedValue = widget.max != null
        ? newValue.clamp(widget.min ?? newValue, widget.max!)
        : (widget.min != null
              ? newValue.clamp(widget.min!, newValue)
              : newValue);
    widget.onChanged(clampedValue);
    HapticFeedback.selectionClick();
  }

  void _decrement() {
    if (!widget.enabled) return;
    final currentValue = widget.value ?? (widget.min ?? 0);
    final newValue = currentValue - widget.step;
    final clampedValue = widget.max != null
        ? newValue.clamp(widget.min ?? newValue, widget.max!)
        : (widget.min != null
              ? newValue.clamp(widget.min!, newValue)
              : newValue);
    widget.onChanged(clampedValue);
    HapticFeedback.selectionClick();
  }

  void _handleTextChanged(String text) {
    if (text.isEmpty) {
      widget.onChanged(null);
      return;
    }

    final parsedValue = int.tryParse(text);
    if (parsedValue != null) {
      widget.onChanged(parsedValue);
    } else {
      // Invalid input, but keep the text for user to correct
      // Don't update the value
    }
  }

  Widget _buildStatusIcon(bool hasValue, bool isValid) {
    if (widget.errorText != null) {
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.error.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.priority_high, size: 18, color: Colors.white),
        ),
      );
    } else if (hasValue && isValid) {
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: widget.accentColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.check, size: 18, color: widget.onAccentColor),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildIncrementButton() {
    final canIncrement =
        widget.enabled &&
        (widget.max == null ||
            widget.value == null ||
            widget.value! < widget.max!);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canIncrement ? _increment : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: canIncrement
                ? widget.accentColor.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add,
            size: 20,
            color: canIncrement
                ? widget.accentColor
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildDecrementButton() {
    final canDecrement =
        widget.enabled &&
        (widget.min == null ||
            widget.value == null ||
            widget.value! > widget.min!);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canDecrement ? _decrement : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: canDecrement
                ? widget.accentColor.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.remove,
            size: 20,
            color: canDecrement
                ? widget.accentColor
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _hasValue();
    final isValid = _isValid();
    final showStatusIcon = hasValue || widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  onChanged: _handleTextChanged,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                  ],
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    labelStyle: const TextStyle(color: Colors.black87),
                    hintText: widget.hintText,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    errorText: widget.errorText,
                    errorMaxLines: 1,
                    // Always reserve space for validation message
                    helperText: widget.errorText == null ? ' ' : null,
                    helperMaxLines: 1,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDecrementButton(),
                          const SizedBox(width: 4),
                          _buildIncrementButton(),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    suffixIcon: hasValue
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.grey[600],
                            onPressed: widget.enabled
                                ? () {
                                    _controller.clear();
                                    widget.onChanged(null);
                                  }
                                : null,
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: hasValue && isValid
                            ? widget.accentColor
                            : Theme.of(context).colorScheme.outline,
                        width: hasValue && isValid ? 2 : 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: showStatusIcon
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
        ),
      ],
    );
  }
}

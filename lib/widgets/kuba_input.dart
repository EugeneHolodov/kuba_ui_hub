import 'package:flutter/material.dart';

class KubaInput extends StatefulWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final String hintText;
  final Color accentColor;
  final Color onAccentColor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const KubaInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Input',
    this.hintText = 'Enter text',
    required this.accentColor,
    required this.onAccentColor,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<KubaInput> createState() => _KubaInputState();
}

class _KubaInputState extends State<KubaInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(KubaInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _hasValue() {
    return widget.value != null && widget.value!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Input Field',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (widget.errorText != null)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.priority_high, size: 16, color: Colors.white),
              )
            else if (_hasValue())
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, size: 16, color: widget.onAccentColor),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
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
            onChanged: (text) => widget.onChanged(text.isEmpty ? null : text),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: const TextStyle(color: Colors.black87),
              hintText: widget.hintText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              errorText: widget.errorText,
              counterText: widget.maxLength != null ? null : '',
              suffixIcon: _hasValue()
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.grey[600],
                      onPressed: () {
                        _controller.clear();
                        widget.onChanged(null);
                      },
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
                  color: _hasValue()
                      ? widget.accentColor
                      : Theme.of(context).colorScheme.outline,
                  width: _hasValue() ? 2 : 1,
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
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ],
    );
  }
}

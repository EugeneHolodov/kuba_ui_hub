import 'package:flutter/material.dart';

class KubaSearchBarBottom extends StatefulWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final bool isPrimary;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final List<Widget>? actions;
  final bool showClearButton;

  const KubaSearchBarBottom({
    super.key,
    this.value,
    required this.onChanged,
    this.hintText = 'Search...',
    this.isPrimary = true,
    this.onSearch,
    this.onClear,
    this.actions,
    this.showClearButton = true,
  });

  @override
  State<KubaSearchBarBottom> createState() => _KubaSearchBarBottomState();
}

class _KubaSearchBarBottomState extends State<KubaSearchBarBottom> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  Color _getAccentColor(BuildContext context) {
    return widget.isPrimary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
  }

  Color _getOnAccentColor(BuildContext context) {
    return widget.isPrimary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(KubaSearchBarBottom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onChanged(value.isEmpty ? null : value);
  }

  void _handleClear() {
    _controller.clear();
    _focusNode.unfocus();
    widget.onChanged(null);
    if (widget.onClear != null) {
      widget.onClear!();
    }
  }

  void _handleSearch() {
    _focusNode.unfocus();
    if (widget.onSearch != null) {
      widget.onSearch!();
    }
  }

  bool get _hasValue => _controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final accentColor = _getAccentColor(context);
    final hasValue = _hasValue;
    // Get keyboard height to adjust padding when keyboard is visible
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 12.0,
            bottom: 12.0 + keyboardHeight,
          ),
          child: Row(
            children: [
              // Search field
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: _handleChanged,
                    onSubmitted: (_) => _handleSearch(),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      prefixIcon: Icon(Icons.search, color: accentColor),
                      suffixIcon: widget.showClearButton && hasValue
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              color: Colors.grey[600],
                              onPressed: _handleClear,
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
                          color: hasValue
                              ? accentColor
                              : Theme.of(context).colorScheme.outline,
                          width: hasValue ? 2 : 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              // Actions
              if (widget.actions != null && widget.actions!.isNotEmpty) ...[
                const SizedBox(width: 8),
                ...widget.actions!,
              ],
              // Search button (if no custom actions)
              if (widget.actions == null || widget.actions!.isEmpty) ...[
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: hasValue ? _handleSearch : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: _getOnAccentColor(context),
                    disabledBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    disabledForegroundColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Search'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

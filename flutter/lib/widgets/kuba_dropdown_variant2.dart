import 'package:flutter/material.dart';
import 'kuba_bottom_sheet/kuba_bottom_sheet.dart';

class KubaDropdownVariant2 extends StatefulWidget {
  final String? value;
  final List<String>? values;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? onMultipleChanged;
  final String labelText;
  final String hintText;
  final bool isPrimary;
  final String bottomSheetTitle;
  final bool multiple;

  const KubaDropdownVariant2({
    super.key,
    this.value,
    this.values,
    required this.options,
    this.onChanged,
    this.onMultipleChanged,
    this.labelText = 'Select Option',
    this.hintText = 'Tap to open',
    this.isPrimary = true,
    this.bottomSheetTitle = 'Select an Option',
    this.multiple = false,
  }) : assert(
         (multiple && values != null && onMultipleChanged != null) ||
             (!multiple && onChanged != null),
         'For single selection: provide onChanged. For multiple: provide values and onMultipleChanged.',
       );

  @override
  State<KubaDropdownVariant2> createState() => _KubaDropdownVariant2State();
}

class _KubaDropdownVariant2State extends State<KubaDropdownVariant2> {
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

  void _showBottomSheetDropdown(BuildContext context) {
    if (widget.multiple) {
      // Multiple selection mode - use action buttons
      final selectedValues = List<String>.from(widget.values ?? []);

      KubaBottomSheet.show(
        context: context,
        title: widget.bottomSheetTitle,
        actionButtonText: 'Confirm',
        onAction: () {
          widget.onMultipleChanged!(selectedValues);
        },
        useSecondaryStyle: !widget.isPrimary,
        child: StatefulBuilder(
          builder: (context, setModalState) {
            final screenHeight = MediaQuery.of(context).size.height;
            final maxListHeight = screenHeight * 0.6;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxListHeight),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    final isSelected = selectedValues.contains(option);
                    return Column(
                      children: [
                        CheckboxListTile(
                          value: isSelected,
                          onChanged: (bool? checked) {
                            setModalState(() {
                              if (checked == true) {
                                selectedValues.add(option);
                              } else {
                                selectedValues.remove(option);
                              }
                            });
                          },
                          title: Text(option),
                          subtitle: Text('Description for $option'),
                          activeColor: _getAccentColor(context),
                        ),
                        if (index < widget.options.length - 1)
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    } else {
      // Single selection mode - closes immediately on selection
      KubaBottomSheet.show(
        context: context,
        title: widget.bottomSheetTitle,
        useSecondaryStyle: !widget.isPrimary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              final isSelected = widget.value == option;
              return Column(
                children: [
                  CheckboxListTile(
                    value: isSelected,
                    onChanged: (bool? checked) {
                      if (checked == true) {
                        widget.onChanged!(option);
                      } else {
                        widget.onChanged!(null);
                      }
                      Navigator.pop(context);
                    },
                    title: Text(option),
                    subtitle: Text('Description for $option'),
                    activeColor: _getAccentColor(context),
                  ),
                  if (index < widget.options.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                ],
              );
            },
          ),
        ),
      );
    }
  }

  String _getDisplayText() {
    if (widget.multiple) {
      final selected = widget.values ?? [];
      if (selected.isEmpty) {
        return '';
      } else if (selected.length == 1) {
        return selected.first;
      } else {
        return '${selected.length} items selected';
      }
    } else {
      return widget.value ?? '';
    }
  }

  bool _hasValue() {
    if (widget.multiple) {
      return (widget.values ?? []).isNotEmpty;
    } else {
      return widget.value != null;
    }
  }

  Widget _buildStatusIcon(BuildContext context, bool hasValue) {
    final accentColor = _getAccentColor(context);
    final onAccentColor = _getOnAccentColor(context);
    return AnimatedOpacity(
      opacity: hasValue ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: hasValue
          ? Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.check, size: 18, color: onAccentColor),
            )
          : const SizedBox(width: 32, height: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _hasValue();
    final accentColor = _getAccentColor(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              readOnly: true,
              controller: TextEditingController(text: _getDisplayText()),
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: const TextStyle(color: Colors.black87),
                hintText: widget.hintText,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                suffixIcon: hasValue
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.grey[600],
                            onPressed: () {
                              if (widget.multiple) {
                                widget.onMultipleChanged!([]);
                              } else {
                                widget.onChanged!(null);
                              }
                            },
                          ),
                        ],
                      )
                    : Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
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
              ),
              onTap: () => _showBottomSheetDropdown(context),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildStatusIcon(context, hasValue),
      ],
    );
  }
}

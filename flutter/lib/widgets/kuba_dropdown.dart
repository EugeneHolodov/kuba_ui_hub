import 'package:flutter/material.dart';
import 'kuba_bottom_sheet.dart';

class KubaDropdown extends StatefulWidget {
  final String? value;
  final List<String>? values;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? onMultipleChanged;
  final String labelText;
  final String hintText;
  final Color accentColor;
  final Color onAccentColor;
  final String bottomSheetTitle;
  final String title;
  final bool multiple;

  const KubaDropdown({
    super.key,
    this.value,
    this.values,
    required this.options,
    this.onChanged,
    this.onMultipleChanged,
    this.labelText = 'Select Option',
    this.hintText = 'Tap to open',
    required this.accentColor,
    required this.onAccentColor,
    this.bottomSheetTitle = 'Select an Option',
    this.title = 'Bottom Sheet Dropdown',
    this.multiple = false,
  }) : assert(
         (multiple && values != null && onMultipleChanged != null) ||
             (!multiple && onChanged != null),
         'For single selection: provide onChanged. For multiple: provide values and onMultipleChanged.',
       );

  @override
  State<KubaDropdown> createState() => _KubaDropdownState();
}

class _KubaDropdownState extends State<KubaDropdown> {
  void _showBottomSheetDropdown(BuildContext context) {
    if (widget.multiple) {
      // Multiple selection mode
      List<String> selectedValues = List<String>.from(widget.values ?? []);

      KubaBottomSheet.show(
        context: context,
        title: widget.bottomSheetTitle,
        child: StatefulBuilder(
          builder: (context, setModalState) {
            // Calculate max height for list (70% of screen height minus header and buttons)
            final screenHeight = MediaQuery.of(context).size.height;
            final maxListHeight = screenHeight * 0.4; // Limit to 40% of screen

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxListHeight),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.options.length,
                      itemBuilder: (context, index) {
                        final option = widget.options[index];
                        final isSelected = selectedValues.contains(option);
                        return CheckboxListTile(
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
                          activeColor: Theme.of(context).colorScheme.primary,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          widget.onMultipleChanged!(selectedValues);
                          Navigator.pop(context);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: widget.accentColor,
                          foregroundColor: widget.onAccentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      // Single selection mode
      KubaBottomSheet.show(
        context: context,
        title: widget.bottomSheetTitle,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final isSelected = widget.value == option;
            return CheckboxListTile(
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
              activeColor: Theme.of(context).colorScheme.primary,
            );
          },
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (_hasValue())
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
            readOnly: true,
            controller: TextEditingController(text: _getDisplayText()),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: const TextStyle(color: Colors.black87),
              hintText: widget.hintText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              suffixIcon: _hasValue()
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
                  color: _hasValue()
                      ? widget.accentColor
                      : Theme.of(context).colorScheme.outline,
                  width: _hasValue() ? 2 : 1,
                ),
              ),
            ),
            onTap: () => _showBottomSheetDropdown(context),
          ),
        ),
      ],
    );
  }
}

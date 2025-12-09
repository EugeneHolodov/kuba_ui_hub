import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'kuba_search_bar_bottom.dart';

/// Combined NavigationBar and SearchBar widget with unified styling
class KubaSearchBarWithNavTabs extends StatefulWidget {
  // Navigation properties
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  // Search properties
  final String? searchValue;
  final ValueChanged<String?> onSearchChanged;
  final String hintText;
  final bool isPrimary;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final bool showClearButton;
  final IconData? leftButtonIcon;
  final VoidCallback? onLeftButtonPressed;
  final IconData? rightButtonIcon;
  final VoidCallback? onRightButtonPressed;
  final List<SearchBarFilterOption>? filterOptions;
  final IconData? actionButtonIcon;
  final VoidCallback? onActionButtonPressed;
  final bool isToggle;
  final ValueChanged<DateTimeRange?>? onDateChanged;
  final DateTimeRange? dateValue;

  const KubaSearchBarWithNavTabs({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.searchValue,
    required this.onSearchChanged,
    this.hintText = 'Search...',
    this.isPrimary = true,
    this.onSearch,
    this.onClear,
    this.showClearButton = true,
    this.leftButtonIcon,
    this.onLeftButtonPressed,
    this.rightButtonIcon,
    this.onRightButtonPressed,
    this.filterOptions,
    this.actionButtonIcon,
    this.onActionButtonPressed,
    this.isToggle = false,
    this.onDateChanged,
    this.dateValue,
  });

  @override
  State<KubaSearchBarWithNavTabs> createState() =>
      _KubaSearchBarWithNavTabsState();
}

class _KubaSearchBarWithNavTabsState extends State<KubaSearchBarWithNavTabs> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;
  bool _isDatePickerMode = false;
  DateTimeRange? _internalDateValue;

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
    _controller = TextEditingController(text: widget.searchValue ?? '');
    _focusNode = FocusNode();
    _internalDateValue = widget.dateValue;
  }

  @override
  void didUpdateWidget(KubaSearchBarWithNavTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchValue != oldWidget.searchValue) {
      _controller.text = widget.searchValue ?? '';
    }
    if (widget.dateValue != oldWidget.dateValue) {
      _internalDateValue = widget.dateValue;
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onSearchChanged(value.isEmpty ? null : value);
  }

  void _handleClear() {
    _controller.clear();
    _focusNode.unfocus();
    widget.onSearchChanged(null);
    if (widget.onClear != null) {
      widget.onClear!();
    }
  }

  bool get _hasValue => _controller.text.isNotEmpty;

  void _toggleMenu() {
    if (_isMenuOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final combinedHeight = 140.0; // nav bar + search bar combined height
    final menuBottomOffset =
        safeAreaBottom + keyboardHeight + combinedHeight + 8;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          Positioned(
            right: 16,
            bottom: menuBottomOffset,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < widget.filterOptions!.length; i++)
                      _buildFilterOption(
                        context,
                        option: widget.filterOptions![i],
                        isFirst: i == 0,
                        isLast: i == widget.filterOptions!.length - 1,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isMenuOpen = false;
      });
    }
  }

  Widget _buildFilterOption(
    BuildContext context, {
    required SearchBarFilterOption option,
    required bool isFirst,
    required bool isLast,
  }) {
    return InkWell(
      onTap: () {
        _toggleMenu();
        option.onPressed();
      },
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(16) : Radius.zero,
        bottom: isLast ? const Radius.circular(16) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(
              option.icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              option.label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _internalDateValue,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Date Range',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
      builder: (BuildContext context, Widget? child) {
        final accentColor = _getAccentColor(context);
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: accentColor,
              secondary: accentColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _internalDateValue = picked;
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(picked);
      }
    }
  }

  String _formatDateRange(DateTimeRange range) {
    final startFormat = DateFormat('MMM dd, yyyy');
    final endFormat = DateFormat('MMM dd, yyyy');
    return '${startFormat.format(range.start)} - ${endFormat.format(range.end)}';
  }

  Widget _buildDatePickerInput(BuildContext context, Color accentColor) {
    final dateText = _internalDateValue != null
        ? _formatDateRange(_internalDateValue!)
        : 'Select date range';
    final hasValue = _internalDateValue != null;
    final suffixIcon = _buildDatePickerSuffixIcon(context, accentColor);

    return InkWell(
      onTap: () => _showDatePicker(context),
      borderRadius: BorderRadius.circular(16),
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          prefixIcon: hasValue
              ? null
              : Icon(Icons.calendar_today, color: accentColor),
          suffixIcon: suffixIcon,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            dateText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: hasValue
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget? _buildSearchSuffixIcon(
    BuildContext context,
    Color accentColor,
    bool hasValue,
  ) {
    final List<Widget> icons = [];

    if (widget.showClearButton && hasValue) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.grey[600],
          onPressed: _handleClear,
        ),
      );
    }

    if (widget.isToggle) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.swap_horiz),
          color: accentColor,
          onPressed: () {
            setState(() {
              _isDatePickerMode = !_isDatePickerMode;
              if (_isDatePickerMode) {
                _controller.clear();
                widget.onSearchChanged(null);
              }
            });
          },
        ),
      );
    }

    if (icons.isEmpty) return null;
    if (icons.length == 1) return icons.first;

    return Row(mainAxisSize: MainAxisSize.min, children: icons);
  }

  Widget? _buildDatePickerSuffixIcon(BuildContext context, Color accentColor) {
    final List<Widget> icons = [];

    if (_internalDateValue != null) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.grey[600],
          onPressed: () {
            setState(() {
              _internalDateValue = null;
            });
            if (widget.onDateChanged != null) {
              widget.onDateChanged!(null);
            }
          },
        ),
      );
    }

    if (widget.isToggle) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.swap_horiz),
          color: accentColor,
          onPressed: () {
            setState(() {
              _isDatePickerMode = !_isDatePickerMode;
              if (!_isDatePickerMode) {
                _internalDateValue = null;
                if (widget.onDateChanged != null) {
                  widget.onDateChanged!(null);
                }
              }
            });
          },
        ),
      );
    }

    if (icons.isEmpty) return null;
    if (icons.length == 1) return icons.first;

    return Row(mainAxisSize: MainAxisSize.min, children: icons);
  }

  Widget _buildPrimaryButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    required Color accentColor,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Icon(icon, color: _getOnAccentColor(context), size: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getAccentColor(context);
    final hasValue = _hasValue;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
            border: Border(
              top: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Navigation tabs - using Material 3 NavigationBar
                NavigationBar(
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onDestinationSelected,
                  height: 72,
                  destinations: widget.destinations,
                ),
                // // Divider
                // Divider(
                //   height: 1,
                //   thickness: 1,
                //   color: Theme.of(context).colorScheme.outlineVariant,
                // ),
                // Search bar
                Padding(
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
                          child: _isDatePickerMode && widget.isToggle
                              ? _buildDatePickerInput(context, accentColor)
                              : TextField(
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  onChanged: _handleChanged,
                                  onSubmitted: (_) {
                                    if (widget.onSearch != null) {
                                      widget.onSearch!();
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: widget.hintText,
                                    filled: true,
                                    fillColor: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: accentColor,
                                    ),
                                    suffixIcon: _buildSearchSuffixIcon(
                                      context,
                                      accentColor,
                                      hasValue,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: hasValue
                                            ? accentColor
                                            : Theme.of(
                                                context,
                                              ).colorScheme.outline,
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
                      // Left optional button
                      if (widget.leftButtonIcon != null &&
                          widget.onLeftButtonPressed != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(widget.leftButtonIcon),
                          color: accentColor,
                          onPressed: widget.onLeftButtonPressed,
                          tooltip: 'Left action',
                        ),
                      ],
                      // Right optional button (filter menu or custom button)
                      if (widget.filterOptions != null &&
                          widget.filterOptions!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        _buildPrimaryButton(
                          context,
                          icon: Icons.sort,
                          onPressed: _toggleMenu,
                          accentColor: accentColor,
                        ),
                      ] else if (widget.rightButtonIcon != null &&
                          widget.onRightButtonPressed != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(widget.rightButtonIcon),
                          color: accentColor,
                          onPressed: widget.onRightButtonPressed,
                          tooltip: 'Right action',
                        ),
                      ],
                      // Action button
                      if (widget.actionButtonIcon != null &&
                          widget.onActionButtonPressed != null) ...[
                        const SizedBox(width: 8),
                        _buildPrimaryButton(
                          context,
                          icon: widget.actionButtonIcon!,
                          onPressed: widget.onActionButtonPressed!,
                          accentColor: accentColor,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

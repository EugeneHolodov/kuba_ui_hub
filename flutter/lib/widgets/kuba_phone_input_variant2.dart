import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'kuba_phone_input.dart';

/// Material 3 phone input without label row (compact style) with
/// country dropdown on the left and validation icon on the right.
///
/// Designed to mirror `KubaInputVariant2` behavior and styling.
class KubaPhoneInputVariant2 extends StatefulWidget {
  final String? countryCode;
  final String? phoneNumber;
  final ValueChanged<String?> onCountryCodeChanged;
  final ValueChanged<String?> onPhoneNumberChanged;
  final String hintText;
  final Color accentColor;
  final Color onAccentColor;
  final String? errorText;
  final bool enabled;

  const KubaPhoneInputVariant2({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.onCountryCodeChanged,
    required this.onPhoneNumberChanged,
    this.hintText = 'Enter phone number',
    required this.accentColor,
    required this.onAccentColor,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<KubaPhoneInputVariant2> createState() => _KubaPhoneInputVariant2State();
}

class _KubaPhoneInputVariant2State extends State<KubaPhoneInputVariant2> {
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phoneNumber ?? '');
    _phoneFocusNode = FocusNode();
    _selectedCountry = supportedCountries.firstWhere(
      (country) => country.code == widget.countryCode,
      orElse: () => supportedCountries.first,
    );

    // Initialize external country code if not set
    if (widget.countryCode == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCountryCodeChanged(_selectedCountry!.code);
      });
    }
  }

  @override
  void didUpdateWidget(KubaPhoneInputVariant2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryCode != oldWidget.countryCode) {
      _selectedCountry = supportedCountries.firstWhere(
        (country) => country.code == widget.countryCode,
        orElse: () => supportedCountries.first,
      );
    }
    if (widget.phoneNumber != oldWidget.phoneNumber) {
      final newValue = widget.phoneNumber ?? '';
      if (_phoneController.text != newValue) {
        _phoneController.text = newValue;
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  bool _hasValue() {
    return (widget.countryCode != null && widget.countryCode!.isNotEmpty) &&
        (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty);
  }

  bool _hasError() => widget.errorText != null;

  Widget _buildStatusIcon(bool hasValue) {
    if (_hasError()) {
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
    } else if (hasValue) {
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

  @override
  Widget build(BuildContext context) {
    final hasValue = _hasValue();
    final hasError = _hasError();
    final showStatusIcon = hasValue || hasError;
    final hasErrorText = widget.errorText != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Country dropdown on the left
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<Country>(
                            value: _selectedCountry,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : (hasValue
                                            ? widget.accentColor
                                            : Theme.of(
                                                context,
                                              ).colorScheme.outline),
                                  width: hasErrorText || hasValue ? 2 : 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2,
                                ),
                              ),
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return supportedCountries.map((Country country) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      country.flag,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      country.code,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                );
                              }).toList();
                            },
                            items: supportedCountries.map((Country country) {
                              return DropdownMenuItem<Country>(
                                value: country,
                                child: Row(
                                  children: [
                                    Text(
                                      country.flag,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            country.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            country.code,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: widget.enabled
                                ? (Country? newCountry) {
                                    if (newCountry != null) {
                                      setState(() {
                                        _selectedCountry = newCountry;
                                      });
                                      widget.onCountryCodeChanged(
                                        newCountry.code,
                                      );
                                    }
                                  }
                                : null,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            iconSize: 24,
                            isExpanded: true,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // Phone number input
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            enabled: widget.enabled,
                            onChanged: (text) => widget.onPhoneNumberChanged(
                              text.isEmpty ? null : text,
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              suffixIcon: _hasValue()
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      color: Colors.grey[600],
                                      onPressed: widget.enabled
                                          ? () {
                                              setState(() {
                                                _selectedCountry =
                                                    supportedCountries.first;
                                              });
                                              _phoneController.clear();
                                              widget.onCountryCodeChanged(
                                                supportedCountries.first.code,
                                              );
                                              widget.onPhoneNumberChanged(null);
                                            }
                                          : null,
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: hasErrorText
                                      ? Theme.of(context).colorScheme.error
                                      : (hasValue
                                            ? widget.accentColor
                                            : Theme.of(
                                                context,
                                              ).colorScheme.outline),
                                  width: hasErrorText || hasValue ? 2 : 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                ),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Reserved space for validation message - seamless with input
                    Container(
                      height: 20,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 4,
                      ),
                      decoration: BoxDecoration(
                        color: hasErrorText
                            ? Theme.of(
                                context,
                              ).colorScheme.error.withOpacity(0.02)
                            : widget.accentColor.withOpacity(0.02),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.errorText ?? ' ',
                        style: TextStyle(
                          color: hasErrorText
                              ? Theme.of(context).colorScheme.error
                              : Colors.transparent,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: showStatusIcon
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      _buildStatusIcon(hasValue),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Country data model for phone input
class Country {
  final String name;
  final String code;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.flag,
  });
}

/// List of supported countries with their codes and flag emojis
const List<Country> supportedCountries = [
  Country(name: 'Norway', code: '+47', flag: '🇳🇴'),
  Country(name: 'Sweden', code: '+46', flag: '🇸🇪'),
  Country(name: 'Denmark', code: '+45', flag: '🇩🇰'),
  Country(name: 'Germany', code: '+49', flag: '🇩🇪'),
  Country(name: 'England', code: '+44', flag: '🇬🇧'),
  Country(name: 'USA', code: '+1', flag: '🇺🇸'),
  Country(name: 'Canada', code: '+1', flag: '🇨🇦'),
];

/// Reusable Material 3 phone number input widget with country code and phone number fields.
///
/// Features:
/// - Separate country code and phone number inputs
/// - Validation icon (check when valid, error when invalid)
/// - Material 3 design with brand colors
/// - Support for error states
///
/// Example:
/// ```dart
/// KubaPhoneInput(
///   countryCode: _countryCode,
///   phoneNumber: _phoneNumber,
///   onCountryCodeChanged: (value) => setState(() => _countryCode = value),
///   onPhoneNumberChanged: (value) => setState(() => _phoneNumber = value),
///   labelText: 'Phone Number',
///   accentColor: Theme.of(context).colorScheme.primary,
///   onAccentColor: Theme.of(context).colorScheme.onPrimary,
/// )
/// ```
class KubaPhoneInput extends StatefulWidget {
  final String? countryCode;
  final String? phoneNumber;
  final ValueChanged<String?> onCountryCodeChanged;
  final ValueChanged<String?> onPhoneNumberChanged;
  final String labelText;
  final String phoneNumberHint;
  final Color accentColor;
  final Color onAccentColor;
  final String? errorText;
  final bool enabled;

  const KubaPhoneInput({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.onCountryCodeChanged,
    required this.onPhoneNumberChanged,
    this.labelText = 'Phone Number',
    this.phoneNumberHint = 'Enter phone number',
    required this.accentColor,
    required this.onAccentColor,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<KubaPhoneInput> createState() => _KubaPhoneInputState();
}

class _KubaPhoneInputState extends State<KubaPhoneInput> {
  late TextEditingController _phoneNumberController;
  late FocusNode _phoneNumberFocusNode;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _phoneNumberController =
        TextEditingController(text: widget.phoneNumber ?? '');
    _phoneNumberFocusNode = FocusNode();
    // Find the selected country based on the current country code
    _selectedCountry = supportedCountries.firstWhere(
      (country) => country.code == widget.countryCode,
      orElse: () => supportedCountries.first,
    );
    // Initialize country code if it's null
    if (widget.countryCode == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCountryCodeChanged(_selectedCountry!.code);
      });
    }
  }

  @override
  void didUpdateWidget(KubaPhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryCode != oldWidget.countryCode) {
      _selectedCountry = supportedCountries.firstWhere(
        (country) => country.code == widget.countryCode,
        orElse: () => supportedCountries.first,
      );
    }
    if (widget.phoneNumber != oldWidget.phoneNumber) {
      final newValue = widget.phoneNumber ?? '';
      if (_phoneNumberController.text != newValue) {
        _phoneNumberController.text = newValue;
        _phoneNumberController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneNumberController.text.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  bool _hasValue() {
    return (widget.countryCode != null && widget.countryCode!.isNotEmpty) &&
        (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty);
  }

  bool _isValid() {
    if (widget.errorText != null) return false;
    if (!_hasValue()) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _hasValue();
    final isValid = _isValid();
    final showStatusIcon = hasValue || widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (showStatusIcon)
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: widget.errorText != null
                        ? Theme.of(context).colorScheme.error
                        : (isValid ? widget.accentColor : Colors.grey),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.errorText != null
                        ? Icons.priority_high
                        : Icons.check,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Code Dropdown
            Container(
              width: 120,
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
              child: DropdownButtonFormField<Country>(
                value: _selectedCountry,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.onCountryCodeChanged(newCountry.code);
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
            const SizedBox(width: 12),
            // Phone Number Input
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
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                  enabled: widget.enabled,
                  onChanged: (text) =>
                      widget.onPhoneNumberChanged(text.isEmpty ? null : text),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: widget.phoneNumberHint,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    errorText: widget.errorText,
                    errorMaxLines: 1,
                    helperText: widget.errorText == null ? ' ' : null,
                    helperMaxLines: 1,
                    suffixIcon: hasValue
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.grey[600],
                            onPressed: widget.enabled
                                ? () {
                                    setState(() {
                                      _selectedCountry = supportedCountries.first;
                                    });
                                    _phoneNumberController.clear();
                                    widget.onCountryCodeChanged(
                                        supportedCountries.first.code);
                                    widget.onPhoneNumberChanged(null);
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
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


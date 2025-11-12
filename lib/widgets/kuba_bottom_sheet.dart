import 'package:flutter/material.dart';

class KubaBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onClose;

  const KubaBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    VoidCallback? onClose,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: true,
      // Material 3 bottom sheet styling
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return KubaBottomSheet(title: title, child: child, onClose: onClose);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title with brand color header (includes handle bar)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle bar with secondary color inside header
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          if (onClose != null) {
                            onClose!();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content
          Flexible(child: child),
        ],
      ),
    );
  }
}

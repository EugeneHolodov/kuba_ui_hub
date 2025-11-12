import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'kuba_bottom_sheet.dart';

// Content widget for bottom sheet
class ReviewInputContent extends StatefulWidget {
  final String widgetName;

  const ReviewInputContent({super.key, required this.widgetName});

  @override
  State<ReviewInputContent> createState() => _ReviewInputContentState();
}

class _ReviewInputContentState extends State<ReviewInputContent> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _textFieldKey = GlobalKey();
  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Scroll to text field when it gains focus
    _commentFocusNode.addListener(() {
      if (_commentFocusNode.hasFocus) {
        // Delay to ensure keyboard is shown
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients &&
              _textFieldKey.currentContext != null) {
            Scrollable.ensureVisible(
              _textFieldKey.currentContext!,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    // Validate comment
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a comment';
      });
      return;
    }

    // Get reviewer ID from storage
    final reviewerId = await StorageService.getReviewerId();
    if (reviewerId == null) {
      setState(() {
        _errorMessage = 'Reviewer not found. Please restart the app.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await ApiService.submitReview(
        reviewerId: reviewerId,
        widgetName: widget.widgetName,
        comment: comment,
      );

      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
        _commentController.clear();
      });

      // Get ScaffoldMessenger and MediaQuery before closing bottom sheet
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final mediaQuery = MediaQuery.of(context);

      // Close bottom sheet first
      if (mounted) {
        Navigator.pop(context);
      }

      // Show success toaster message at the top after bottom sheet closes
      Future.delayed(const Duration(milliseconds: 300), () {
        final screenHeight = mediaQuery.size.height;
        final topPadding = mediaQuery.padding.top;
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Review submitted successfully!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: screenHeight - topPadding - 140,
              left: 16,
              right: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Failed to submit review. Please try again.';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Error: ${e.toString()}')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scrollable content area
        Flexible(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  'Share your thoughts about ${widget.widgetName}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),

                // Comment Input
                TextField(
                  key: _textFieldKey,
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  maxLines: 4,
                  enabled: !_isSubmitting && !_isSubmitted,
                  decoration: InputDecoration(
                    labelText: 'Your Comment',
                    hintText: 'What do you think about this widget?',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    errorText: _errorMessage,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Submit Button - Always at bottom
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: _isSubmitting ? null : _submitReview,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        _isSubmitting ? 'Submitting...' : 'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReviewInput extends StatelessWidget {
  final String widgetName;

  const ReviewInput({super.key, required this.widgetName});

  // Static method to show review input in bottom sheet
  static Future<void> showBottomSheet({
    required BuildContext context,
    required String widgetName,
  }) {
    return KubaBottomSheet.show(
      context: context,
      title: 'Leave a Review',
      child: ReviewInputContent(widgetName: widgetName),
    );
  }

  // Method to create Material 3 FloatingActionButton
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        ReviewInput.showBottomSheet(context: context, widgetName: widgetName);
      },
      tooltip: 'Leave a Review',
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.rate_review),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is kept for backward compatibility but should not be used
    // Use buildFloatingActionButton() instead
    return buildFloatingActionButton(context);
  }
}

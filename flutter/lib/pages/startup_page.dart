import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/kuba_dropdown.dart';
import '../home_page.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  List<Reviewer> _reviewers = [];
  String? _selectedReviewerName;
  Reviewer? _selectedReviewer;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadReviewers();
  }

  Future<void> _loadReviewers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final reviewers = await ApiService.getReviewers();
      setState(() {
        _reviewers = reviewers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Failed to load reviewers. Please check your connection.';
        _isLoading = false;
      });
    }
  }

  void _onReviewerSelected(String? reviewerName) {
    if (reviewerName != null) {
      final reviewer = _reviewers.firstWhere((r) => r.name == reviewerName);
      setState(() {
        _selectedReviewerName = reviewerName;
        _selectedReviewer = reviewer;
      });
    } else {
      setState(() {
        _selectedReviewerName = null;
        _selectedReviewer = null;
      });
    }
  }

  Future<void> _saveAndContinue() async {
    if (_selectedReviewer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reviewer'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Save reviewer to storage
      await StorageService.saveReviewer(
        _selectedReviewer!.id,
        _selectedReviewer!.name,
      );

      // Navigate to home page
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving reviewer: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    // Logo/Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'Welcome to Kuba UI Hub',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please select your name to continue',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Loading state
                    if (_isLoading)
                      const Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading reviewers...'),
                        ],
                      ),

                    // Error state
                    if (_errorMessage != null && !_isLoading)
                      Column(
                        children: [
                          Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onErrorContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: _loadReviewers,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),

                    // Dropdown
                    if (!_isLoading && _errorMessage == null)
                      KubaDropdown(
                        value: _selectedReviewerName,
                        options: _reviewers.map((r) => r.name).toList(),
                        onChanged: _onReviewerSelected,
                        accentColor: Theme.of(context).colorScheme.primary,
                        onAccentColor: Theme.of(context).colorScheme.onPrimary,
                        labelText: 'Select Your Name',
                        hintText: 'Tap to select',
                        bottomSheetTitle: 'Select Your Name',
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Fixed button at bottom
            if (!_isLoading && _errorMessage == null)
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: FilledButton(
                    onPressed: _saveAndContinue,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

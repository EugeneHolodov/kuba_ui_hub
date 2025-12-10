import 'package:flutter/material.dart';
import '../widgets/kuba_fab_menu.dart';
import '../widgets/review_input.dart';

/// A page demonstrating the Material 3 FAB Menu implementation
class FabMenuPage extends StatefulWidget {
  const FabMenuPage({super.key});

  @override
  State<FabMenuPage> createState() => _FabMenuPageState();
}

class _FabMenuPageState extends State<FabMenuPage> {
  String _lastAction = 'No action yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 FAB Menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'FAB Menu Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Using KubaFabMenu Widget',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Click the FAB button in the bottom right corner to see the menu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Last Action:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastAction,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Review button with unique hero tag
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              heroTag: 'review_button_fab_menu',
              onPressed: () {
                ReviewInput.showBottomSheet(
                  context: context,
                  widgetName: 'kuba_fab_menu',
                );
              },
              tooltip: 'Leave a Review',
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.rate_review),
            ),
          ),
          // FAB Menu with unique hero tag
          _buildReusableFabMenu(heroTag: 'fab_menu_button'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildReusableFabMenu({Object? heroTag}) {
    return KubaFabMenu(
      mainIcon: Icons.add,
      tooltip: 'Create new',
      showScrim: true,
      heroTag: heroTag,
      onMenuStateChanged: (isOpen) {
        if (isOpen) {
          setState(() {
            _lastAction = 'Menu opened';
          });
        }
      },
      menuItems: [
        FabMenuItem(
          icon: Icons.image,
          label: 'Image',
          tooltip: 'Add image',
          onPressed: () {
            setState(() {
              _lastAction = 'Image selected';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image option selected')),
            );
          },
        ),
        FabMenuItem(
          icon: Icons.video_library,
          label: 'Video',
          tooltip: 'Add video',
          onPressed: () {
            setState(() {
              _lastAction = 'Video selected';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Video option selected')),
            );
          },
        ),
        FabMenuItem(
          icon: Icons.attach_file,
          label: 'File',
          tooltip: 'Add file',
          onPressed: () {
            setState(() {
              _lastAction = 'File selected';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('File option selected')),
            );
          },
        ),
        FabMenuItem(
          icon: Icons.note_add,
          label: 'Note',
          tooltip: 'Add note',
          onPressed: () {
            setState(() {
              _lastAction = 'Note selected';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Note option selected')),
            );
          },
        ),
      ],
    );
  }
}

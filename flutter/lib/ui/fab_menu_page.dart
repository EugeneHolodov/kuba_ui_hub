import 'package:flutter/material.dart';
import '../widgets/kuba_fab_menu.dart';

/// A page demonstrating the Material 3 FAB Menu implementation
class FabMenuPage extends StatefulWidget {
  const FabMenuPage({super.key});

  @override
  State<FabMenuPage> createState() => _FabMenuPageState();
}

class _FabMenuPageState extends State<FabMenuPage> {
  bool _useReusableWidget = true;
  String _lastAction = 'No action yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 FAB Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_useReusableWidget ? Icons.web : Icons.widgets),
            tooltip: _useReusableWidget
                ? 'Switch to custom implementation'
                : 'Switch to reusable widget',
            onPressed: () {
              setState(() {
                _useReusableWidget = !_useReusableWidget;
              });
            },
          ),
        ],
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
                _useReusableWidget
                    ? 'Using KubaFabMenu Widget'
                    : 'Using Custom Implementation',
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
      floatingActionButton: _useReusableWidget
          ? _buildReusableFabMenu()
          : const Material3FabMenu(),
    );
  }

  Widget _buildReusableFabMenu() {
    return KubaFabMenu(
      mainIcon: Icons.add,
      tooltip: 'Create new',
      showScrim: true,
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

/// Material 3 FAB Menu implementation
class Material3FabMenu extends StatefulWidget {
  const Material3FabMenu({super.key});

  @override
  State<Material3FabMenu> createState() => _Material3FabMenuState();
}

class _Material3FabMenuState extends State<Material3FabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 56.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Menu items
          ScaleTransition(
            scale: _expandAnimation,
            child: FadeTransition(
              opacity: _expandAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.image,
                    label: 'Image',
                    onTap: () {
                      _toggleMenu();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Image selected')),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.video_library,
                    label: 'Video',
                    onTap: () {
                      _toggleMenu();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Video selected')),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.attach_file,
                    label: 'File',
                    onTap: () {
                      _toggleMenu();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File selected')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Main FAB
          FloatingActionButton(
            onPressed: _toggleMenu,
            shape: _isExpanded
                ? const CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: _isExpanded ? 2 : 6,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isExpanded ? Icons.close : Icons.add,
                key: ValueKey(_isExpanded),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Material(
          color: colorScheme.surfaceContainerHighest,
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Small FAB
        SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            mini: true,
            onPressed: onTap,
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
            elevation: 2,
            child: Icon(icon, size: 20),
          ),
        ),
      ],
    );
  }
}
